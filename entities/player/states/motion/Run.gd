extends "res://entities/player/states/motion/Move.gd"

onready var timer = $Timer

func enter():
	owner.camera_pointer.input_enabled = false
	if timer.paused:
		timer.paused = false
	else:
		timer.start()
	owner.get_node("AnimationPlayer").play("run")
	.enter()

func exit():
	owner.camera_pointer.input_enabled = true
	timer.paused = true
	.exit()

func check_state_conditions():
	var input_direction = get_input_direction()
	if not input_direction:
		emit_signal("finished", "idle")
	if not Input.is_action_pressed("run"):
		emit_signal("finished", "walk")
	return input_direction

func _on_Timer_timeout():
	signals.emit_signal("noise_emitted", owner.global_position)
