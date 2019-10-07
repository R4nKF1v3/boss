extends "res://entities/player/states/motion/Move.gd"

onready var camera_pointer = owner.get_node("CameraPointer")

func _ready():
	SPEED = 400

func enter():
	camera_pointer.input_enabled = false
	.enter()

func exit():
	camera_pointer.input_enabled = true
	.exit()

func check_state_conditions():
	var input_direction = get_input_direction()
	if not input_direction:
		emit_signal("finished", "idle")
	if not Input.is_action_pressed("run"):
		emit_signal("finished", "walk")
	return input_direction