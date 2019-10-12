extends "res://entities/npcs/enemies/shadow/states/Motion.gd"

onready var timer = $BoredomTimer

# Initialize the state. E.g. change the animation
func enter():
	print("Now Idle")
	timer.start(randi() % 10 + 8)
	owner.get_node("AnimationPlayer").play("idle")

# Clean up the state. Reinitialize values like a timer
func exit():
	if not timer.is_stopped():
		timer.stop()

func update(delta):
	if owner.can_see_player():
		owner.look_at(owner.target.global_position)
		if can_reach_player():
			emit_signal("finished", "chase")

func _on_Timer_timeout():
	emit_signal("finished", "wander")
