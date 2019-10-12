extends "res://entities/npcs/enemies/shadow/states/Motion.gd"

# Initialize the state. E.g. change the animation
func enter():
	print("Now chasing")
	owner.get_node("AnimationPlayer").play("chase")
	$UpdatePath.start()
	.enter()

func exit():
	$UpdatePath.stop()
	.exit()

func update(delta):
	var can_see_player = owner.can_see_player()
	if not objective_path.size() == 0:
		travel_to_objective(delta)
		if can_see_player:
			owner.look_at(owner.target.global_position)
	elif can_see_player:
		owner.look_at(owner.target.global_position)
		if owner.can_reach_player():
			self.objective_path = owner.navigation.get_simple_path(owner.global_position, owner.target.global_position)
		else:
			emit_signal("finished", "searching")
	else:
		emit_signal("finished", "searching")

func _on_UpdatePath_timeout():
	if owner.can_see_player():
		self.objective_path = owner.navigation.get_simple_path(owner.global_position, owner.target.global_position)
