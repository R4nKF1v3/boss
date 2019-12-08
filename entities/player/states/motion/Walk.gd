extends "res://entities/player/states/motion/Move.gd"

func enter():
	.enter()
	parent.get_node("AnimationPlayer").play("walk")

func check_state_conditions():
	var input_direction = get_input_direction()
	if not input_direction:
		emit_signal("finished", "idle")
	if Input.is_action_pressed("run"):
		emit_signal("finished", "run")
	return input_direction
