extends "res://entities/npcs/enemies/shadow/states/Motion.gd"

# Initialize the state. E.g. change the animation
func enter():
	print("Now chasing")
	owner.get_node("AnimationPlayer").play("chase")

func update(delta):
	if owner.can_see_player():
		objective_path = owner.navigation2D.get_simple_path(owner.global_position, owner.target.global_position)
		owner.emit_signal("new_path", objective_path)
	if not objective_path.empty():
		travel_to_objective(delta)
	elif objective_path.empty():
		emit_signal("finished", "idle")
