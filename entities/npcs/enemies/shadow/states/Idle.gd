extends "res://entities/npcs/enemies/shadow/states/Motion.gd"

onready var timer = $BoredomTimer

# Initialize the state. E.g. change the animation
func enter():
	print("Entered Idle")
	owner.player_last_pos = null
	timer.start(randi() % 10 + 8)
	owner.get_node("AnimationPlayer").play("idle")

# Clean up the state. Reinitialize values like a timer
func exit():
	if not timer.is_stopped():
		timer.stop()
	.exit()

func update(delta):
	if owner.can_see_player():
		owner.look_at = owner.target.global_position
		if owner.can_reach_player():
			emit_signal("finished", "chase")
		else:
			emit_signal("finished", "searching")
	owner.curr_vel = Vector2()

func _on_Timer_timeout():
	if owner.navigation.is_valid_node(owner.global_position):
		emit_signal("finished", "wander")
