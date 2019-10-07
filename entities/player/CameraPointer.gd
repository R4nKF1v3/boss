extends Position2D

const POINTER_LIMIT = 250

var target : Vector2 = Vector2.ZERO
var input_enabled = true
var weight = 0.03

func _physics_process(delta):
	if not input_enabled:
		_update_target(owner.look_direction * (POINTER_LIMIT * 0.7))
		weight = 0.05
	else:
		weight = 0.03
	position = lerp(position, target, weight)

func _input(event):
	if input_enabled:
		if event is InputEventMouseMotion:
			_update_target(get_local_mouse_position())

func _update_target(mouse_pos):
	target = mouse_pos.clamped(POINTER_LIMIT)






