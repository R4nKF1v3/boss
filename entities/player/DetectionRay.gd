extends RayCast2D

func set_position_and_target(position : Vector2, target : Vector2):
	position = to_local(position)
	cast_to = to_local(target) - position