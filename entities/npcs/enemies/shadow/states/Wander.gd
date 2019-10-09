extends "res://entities/npcs/enemies/shadow/states/Motion.gd"

# Initialize the state. E.g. change the animation
func enter():
	print("Now wandering")
	find_valid_path()
	print("My valid path is:")
	print(objective_path)
	owner.get_node("AnimationPlayer").play("wander")

func exit():
	objective_path = []

func update(delta):
	if owner.can_see_player():
		emit_signal("finished", "chase")
	if not objective_path.empty():
		travel_to_objective(delta)
	if objective_path.empty():
		emit_signal("finished", "idle")

func find_valid_path():
	while objective_path.empty():
		randomize()
		var objective = Vector2(owner.global_position.x + (rand_range(-300, 300)), owner.global_position.y + (rand_range(-300, 300)))
		objective_path = owner.navigation2D.get_simple_path(owner.global_position, objective)
	owner.emit_signal("new_path", objective_path)