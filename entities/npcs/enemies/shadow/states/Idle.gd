extends "res://entities/npcs/enemies/shadow/states/Motion.gd"

onready var timer = $BoredomTimer

# Initialize the state. E.g. change the animation
func enter():
	print("Entered Idle")
	owner.player_last_pos = null
	timer.start(randi() % 10 + 8)
	anim_player.play("idle")

# Clean up the state. Reinitialize values like a timer
func exit():
	if not timer.is_stopped():
		timer.stop()
	.exit()

func update(delta):
	owner.curr_vel = Vector2()
	if owner.can_see_player():
		if owner.can_reach_player():
			emit_signal("finished", "chase")
		else:
			owner.look_at = owner.player_last_pos

func _on_Timer_timeout():
	if owner.navigation.is_valid_node(owner.global_position):
		emit_signal("finished", "wander")
