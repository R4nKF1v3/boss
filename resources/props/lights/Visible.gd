extends Node2D

func _draw():
	#if Options.get_complex_lights() == false: return
	#draw_circle(Vector2(0.0, 0.0), 5.0, Color.green)
	var points = PoolVector2Array()
	var colors = PoolColorArray()
	for i in range(0, owner.SHADOW_RESOLUTION):
		var index_plus = i + 1
		if index_plus == owner.SHADOW_RESOLUTION: index_plus = 0
		var angle_a = (float(i)/owner.SHADOW_RESOLUTION)*PI*2.0
		var angle_b = (float(i+1)/owner.SHADOW_RESOLUTION)*PI*2.0
		var power_a = owner.ray_lengths[i]/owner.light_size
		var power_b = owner.ray_lengths[index_plus]/owner.light_size
		points.append(Vector2(0.0, 0.0))
		points.append(owner.make_point(angle_a, owner.ray_lengths[i]))
		points.append(owner.make_point(angle_b, owner.ray_lengths[index_plus]))
		colors.append(owner.light_colour)
		colors.append(owner.light_colour.linear_interpolate(Color(owner.light_colour.r, owner.light_colour.g, owner.light_colour.b, 0.0), power_a))
		colors.append(owner.light_colour.linear_interpolate(Color(owner.light_colour.r, owner.light_colour.g, owner.light_colour.b, 0.0), power_b))
	draw_polygon(points, colors)
