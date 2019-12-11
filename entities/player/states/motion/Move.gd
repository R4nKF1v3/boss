extends "res://entities/player/states/motion/Motion.gd"

export(float) var SPEED

func enter():
	velocity = Vector2()

	var input_direction = get_input_direction()
	update_look_direction(input_direction)

func handle_input(event):
	return .handle_input(event)

func update(delta):
	.update(delta)
	var input_direction = check_state_conditions()
	update_look_direction(input_direction)

	move(SPEED, input_direction)

func check_state_conditions():
	return null

func move(speed, direction):
	velocity = direction.normalized() * speed
	parent.current_velocity = velocity
