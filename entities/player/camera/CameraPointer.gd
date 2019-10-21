extends Position2D

const POINTER_LIMIT = 100

onready var player = get_parent().get_node("Player")
onready var camera_offset = $CameraOffset

var target : Vector2 = Vector2.ZERO
var weight = 0.05

func _physics_process(delta):
	position = player.position
	camera_offset.position = lerp(camera_offset.position, target, weight)

func _input(event):
	if event is InputEventMouseMotion:
		_update_target(get_local_mouse_position())

func _update_target(mouse_pos):
	target = mouse_pos.clamped(POINTER_LIMIT)


