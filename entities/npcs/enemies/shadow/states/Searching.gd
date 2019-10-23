extends "res://entities/npcs/enemies/shadow/states/Motion.gd"

onready var timer = $SearchTime

# Initialize the state. E.g. change the animation
func enter():
	print("Now Searching")
	timer.start()
	owner.get_node("AnimationPlayer").play("searching")

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
			owner.curr_vel = Vector2()
	else:
		search_cycle(delta)

func search_cycle(delta):
	find_valid_path()
	travel_to_objective(delta)

func find_valid_path():
	if objective_path.size() <= 1:
		if owner.player_last_pos:
			randomize()
			var objective = Vector2(owner.player_last_pos.x + (rand_range(-100, 100)), owner.player_last_pos.y + (rand_range(-100, 100)))
			self.objective_path = owner.navigation.get_simple_path(owner.global_position, objective)
		else:
			randomize()
			var objective = Vector2(owner.global_position.x + (rand_range(-300, 300)), owner.global_position.y + (rand_range(-300, 300)))
			set_objective_path(owner.navigation.get_simple_path(owner.global_position, objective))

func _on_SearchTime_timeout():
	emit_signal("finished", "idle")
