extends Position2D

const POINTER_LIMIT = 250

var target : Vector2 = Vector2.ZERO

func _physics_process(delta):
	position = lerp(position, target, 0.03)

func _input(event):
	if event is InputEventMouseMotion:
		_update_target()

func _update_target():
	var mouse_pos = get_local_mouse_position()
	target = mouse_pos.clamped(POINTER_LIMIT)






