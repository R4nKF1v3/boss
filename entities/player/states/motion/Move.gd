extends "res://entities/player/states/motion/Motion.gd"

export(float) var SPEED

func enter():
	speed = 0.0
	velocity = Vector2()

	var input_direction = get_input_direction()
	update_look_direction(input_direction)
	owner.get_node("AnimationPlayer").play("walk")

func handle_input(event):
	return .handle_input(event)

func update(delta):
	var input_direction = check_state_conditions()
	update_look_direction(input_direction)

	speed = SPEED
	var collision_info = move(speed, input_direction)
	if not collision_info:
		return
#	if speed == MAX_RUN_SPEED and collision_info.collider.is_in_group("environment"):
#		return null

func check_state_conditions():
	return null

func move(speed, direction):
	velocity = direction.normalized() * speed
	owner.move_and_slide(velocity, Vector2(), 5, 2)
	if owner.get_slide_count() == 0:
		return
	return owner.get_slide_collision(0)
