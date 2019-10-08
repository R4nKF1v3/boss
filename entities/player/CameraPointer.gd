extends Position2D

const POINTER_LIMIT = 250

onready var player = get_parent().get_node("Player")
onready var camera_offset = $CameraOffset

var target : Vector2 = Vector2.ZERO
var input_enabled = true setget set_input_enabled
var weight = 0.04

func _physics_process(delta):
	if not input_enabled:
		_update_target(player.look_direction * (POINTER_LIMIT * 0.7))
		weight = 0.05
	else:
		weight = 0.03
	position = player.position
	camera_offset.position = lerp(camera_offset.position, target, weight)

func _input(event):
	if input_enabled:
		if event is InputEventMouseMotion:
			_update_target(get_local_mouse_position())

func _update_target(mouse_pos):
	target = mouse_pos.clamped(POINTER_LIMIT)

func set_input_enabled(value):
	input_enabled = value
	if value:
		_update_target(get_local_mouse_position())




