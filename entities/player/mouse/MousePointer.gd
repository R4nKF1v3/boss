extends Position2D

const INTERACTION_RANGE = 80
const hotspot = Vector2(12, 12)

onready var player : Player = owner.get_node("Player")
onready var area : Area2D = $MouseArea
onready var raycast : RayCast2D = $MouseArea/RayCast2D
var default_texture = load("res://resources/cursors/cursor-idle.png")

var hovering_elements = []
var texture_loaded

func _ready():
	area.connect("area_entered", self, "on_area_entered")
	area.connect("area_exited", self, "on_area_exited")

func _input(event):
	if can_interact_with_element():
		hovering_elements[0].handle_event(event)

func _physics_process(delta):
	# Cursor rendering
	var texture
	
	if can_interact_with_element():
		texture = hovering_elements[0].get_mouse_texture()
	else:
		texture = default_texture
	
	if texture_loaded != texture:
		Input.set_custom_mouse_cursor(texture, 0, hotspot)
		texture_loaded = texture
	
	# Update position
	global_position = get_global_mouse_position()

func can_interact_with_element() -> bool:
	if hovering_elements.size() > 0:
		print("There's an element behind the mouse")
		var space_state = get_world_2d().direct_space_state
		var target = hovering_elements[0].get_global_position()
		raycast.set_position_and_target(player.global_position, target)
		raycast.force_raycast_update()
		if raycast.is_colliding():
			var result = raycast.get_collision_point()
			print(result)
			if player.global_position.distance_to(result) <= INTERACTION_RANGE:
				return true
	return false

func on_area_entered(area):
	if area.owner.is_interactuable:
		hovering_elements.push_front(area.owner)
		hovering_elements.sort_custom(HoveringElementsSorter, "sort")

func on_area_exited(area):
	if hovering_elements.has(area.owner):
		hovering_elements.remove(hovering_elements.find(area.owner))
		if hovering_elements.size() > 0:
			hovering_elements.sort_custom(HoveringElementsSorter, "sort")



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