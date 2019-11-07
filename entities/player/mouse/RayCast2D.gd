extends RayCast2D

func set_position_and_target(position : Vector2, target : Vector2):
	position = to_local(position)
	cast_to = to_local(target) - position

func get_collision_point() -> Vector2:
	var result = .get_collision_point()
	return to_global(result)