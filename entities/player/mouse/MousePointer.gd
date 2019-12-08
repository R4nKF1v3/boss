extends Position2D

export (float) var INTERACTION_RANGE = 80
const hotspot = Vector2(12, 12)

onready var player : Player = owner.get_node("Player")
onready var area : Area2D = $MouseArea
onready var raycast : RayCast2D = $RayCast2D
var default_texture = load("res://resources/cursors/cursor-idle.png")

var hovering_elements = []
var texture_loaded

func _ready():
	area.connect("area_entered", self, "on_area_entered")
	area.connect("area_exited", self, "on_area_exited")

func _input(event):
	call_deferred("determine_event", event)

func determine_event(event):
	if event.is_action_type() && can_interact_with_element():
		hovering_elements[0].handle_event(event)

func _process(delta):
	# Update position
	global_position = get_global_mouse_position()
	
	call_deferred("cursor_render")

func cursor_render():
	# Cursor rendering
	var texture
	
	if can_interact_with_element():
		texture = hovering_elements[0].mouse_texture
	else:
		texture = default_texture
	
	if texture_loaded != texture:
		Input.set_custom_mouse_cursor(texture, 0, hotspot)
		texture_loaded = texture

func can_interact_with_element() -> bool:
	if hovering_elements.size() > 0:
		while !is_instance_valid(hovering_elements[0]):
			hovering_elements.pop_front()
			set_raycast_exceptions()
			if hovering_elements.size() == 0:
				return false
		
		var target_element = hovering_elements[0]
		var target_area = target_element.get_interaction_area()
		
		var center = (global_position - player.global_position).normalized()
		raycast.global_position = player.global_position
		
		raycast.cast_to = center * INTERACTION_RANGE
		raycast.force_raycast_update()
		var collider = raycast.get_collider()
		return collider == target_area
	
	return false

func on_area_entered(area):
	if area.owner.is_interactuable:
		hovering_elements.push_front(area.owner)
		hovering_elements.sort_custom(HoveringElementsSorter, "sort")
		set_raycast_exceptions()

func on_area_exited(area):
	if hovering_elements.has(area.owner):
		hovering_elements.remove(hovering_elements.find(area.owner))
		if hovering_elements.size() > 0:
			hovering_elements.sort_custom(HoveringElementsSorter, "sort")
		set_raycast_exceptions()
		

func set_raycast_exceptions():
	raycast.clear_exceptions()
	raycast.add_exception(area)
	if hovering_elements.size() > 0:
		var elements_copy = hovering_elements.duplicate()
		var target_element = elements_copy.pop_front()
		var tar_body = target_element.get_collision_body()
		if tar_body:
			raycast.add_exception(tar_body)
		for element in elements_copy:
			var inarea = element.get_interaction_area()
			if inarea:
				raycast.add_exception(inarea)
			var coll = element.get_collision_body()
			if coll:
				raycast.add_exception(coll)


class HoveringElementsSorter:
	static func sort(a, b) -> bool:
		if get_absolute_z_index(a) > get_absolute_z_index(b):
			return true
		return false
	
	static func get_absolute_z_index(target: Node2D) -> int:
		var node = target;
		var z_index = 0;
		while node and node.is_class('Node2D'):
			z_index += node.z_index;
			if !node.z_as_relative:
				break;
			node = node.get_parent();
		return z_index;