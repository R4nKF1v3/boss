extends InteractuableElement

const SHADOW_RESOLUTION = 720

export (bool) var starts_toggled = false
export (bool) var starts_flickering = false
export (Array, float) var flickering_timings = []
export (Color) var light_colour# setget update_colour
export (float) var light_size# setget update_size
export (Texture) var on_toggle_effect_texture
export (Texture) var on_toggle_emmiter_texture

onready var effect = $Light/Effect
onready var emmiter = $Light/Emmiter

onready var effect_base_tx = effect.texture
onready var emmiter_base_tx = emmiter.texture

onready var raycast = $Light/RayCast2D

onready var vis = $Light/Visible

var ray_lengths


func get_interaction_area():
	return $Light/InteractionArea

func toggle():
	vis.visible = !vis.visible
	
	if effect.texture != on_toggle_effect_texture:
		effect.texture = on_toggle_effect_texture
	elif effect.texture != effect_base_tx:
		effect.texture = effect_base_tx
	
	if emmiter.texture != on_toggle_emmiter_texture:
		emmiter.texture = on_toggle_emmiter_texture
	elif emmiter.texture != emmiter_base_tx:
		emmiter.texture = emmiter_base_tx

func update_colour(value):
	light_colour = value
	vis.update()

func update_size(value):
	light_size = value
	vis.update()

func update_ray_lengths():
	for i in range(0, SHADOW_RESOLUTION):
		var angle = (float(i)/SHADOW_RESOLUTION)*PI*2.0
		raycast.cast_to = make_point(angle, light_size)
		#print(make_point(angle, 5.0))
		raycast.force_raycast_update()
		if raycast.is_colliding():
			var collision_pos = raycast.get_collision_point() - global_position
			var collision_length = Vector2().distance_to(collision_pos)
			ray_lengths[i] = collision_length
		else:
			ray_lengths[i] = light_size
	vis.update()

func make_point(direction, amount):
	var result = Vector2(0.0, 0.0)
	result.x += cos(direction) * amount
	result.y -= sin(direction) * amount
	return result

func _ready():
	update_ray_lengths()
	vis.update()
	if starts_flickering:
		var event = WorldEvents.event_types.Flickering.new()
		event.timings = flickering_timings if flickering_timings.size() != 0 else [0.1]
		event.duration = null
		event.toggle_after_finish = false
		flicker(event)
	elif starts_toggled:
		toggle()

func _enter_tree():
	ray_lengths = []
	for i in range(0, SHADOW_RESOLUTION):
		ray_lengths.append(10.0)
