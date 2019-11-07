extends RayCast2D

func set_position_and_target(newPosition : Vector2, target : Vector2):
	position = to_local(newPosition)
	cast_to = to_local(target) - position