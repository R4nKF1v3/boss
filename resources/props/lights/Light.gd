extends InteractuableElement

export (Texture) var on_toggle_effect_texture
export (Texture) var on_toggle_emmiter_texture

onready var effect = $Light/Effect
onready var emmiter = $Light/Emmiter

onready var effect_base_tx = effect.texture
onready var emmiter_base_tx = emmiter.texture

func get_interaction_area():
	return $Light/InteractionArea

func toggle():
	pass
	
	if effect.texture != on_toggle_effect_texture:
		effect.texture = on_toggle_effect_texture
	elif effect.texture != effect_base_tx:
		effect.texture = effect_base_tx
	
	if emmiter.texture != on_toggle_emmiter_texture:
		emmiter.texture = on_toggle_emmiter_texture
	elif emmiter.texture != emmiter_base_tx:
		emmiter.texture = emmiter_base_tx


const SHADOW_RESOLUTION = 720

export (Color) var light_colour# setget update_colour
export (float) var light_size# setget update_size

onready var raycast = $Light/RayCast2D

onready var vis = $Light/Visible

var ray_lengths

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

func _draw():
	#if Options.get_complex_lights() == false: return
	#draw_circle(Vector2(0.0, 0.0), 5.0, Color.green)
	var points = PoolVector2Array()
	var colors = PoolColorArray()
	for i in range(0, SHADOW_RESOLUTION):
		var index_plus = i + 1
		if index_plus == SHADOW_RESOLUTION: index_plus = 0
		var angle_a = (float(i)/SHADOW_RESOLUTION)*PI*2.0
		var angle_b = (float(i+1)/SHADOW_RESOLUTION)*PI*2.0
		var power_a = ray_lengths[i]/light_size
		var power_b = ray_lengths[index_plus]/light_size
		points.append(Vector2(0.0, 0.0))
		points.append(make_point(angle_a, ray_lengths[i]))
		points.append(make_point(angle_b, ray_lengths[index_plus]))
		colors.append(light_colour)
		colors.append(light_colour.linear_interpolate(Color(light_colour.r, light_colour.g, light_colour.b, 0.0), power_a))
		colors.append(light_colour.linear_interpolate(Color(light_colour.r, light_colour.g, light_colour.b, 0.0), power_b))
	draw_polygon(points, colors)

func _ready():
	update_ray_lengths()
	vis.update()

func _enter_tree():
	ray_lengths = []
	for i in range(0, SHADOW_RESOLUTION):
		ray_lengths.append(10.0)
