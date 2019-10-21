extends "res://entities/player/states/motion/Move.gd"

func enter():
	owner.camera_follow = false
	owner.get_node("AnimationPlayer").play("run")
	.enter()

func exit():
	owner.camera_follow = true
	.exit()

func check_state_conditions():
	var input_direction = get_input_direction()
	if not input_direction:
		emit_signal("finished", "idle")
	if not Input.is_action_pressed("run"):
		emit_signal("finished", "walk")
	return input_direction
