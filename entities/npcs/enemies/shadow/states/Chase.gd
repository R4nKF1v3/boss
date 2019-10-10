extends "res://entities/npcs/enemies/shadow/states/Motion.gd"

# Initialize the state. E.g. change the animation
func enter():
	print("Now chasing")
	owner.get_node("AnimationPlayer").play("chase")

func update(delta):
	if owner.can_see_player():
		set_objective_path(owner.navigation2D.get_simple_path(owner.global_position, owner.target.global_position))
	if not objective_path.size() == 0:
		travel_to_objective(delta)
	else:
		emit_signal("finished", "idle")
