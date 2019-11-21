extends "res://entities/state_machine.gd"

func _ready():
	states_map = {
		"idle": $Idle,
		"wander": $Wander,
		"chase": $Chase,
		"searching": $Searching,
		"attack": $Attack,
	}
	START_STATE = $Idle
	signals.connect("noise_emitted", self, "_on_noise_emmited")

func _change_state(state_name):
	"""
	The base state_machine interface this node extends does most of the work
	"""
	print(state_name)
	if not _active:
		return
	if state_name == "attack":
		states_stack.push_front(states_map[state_name])
	if state_name == "prev_idle":
		var prev_state = states_stack.pop_back()
		prev_state.exit()
		state_name = "idle"
		print(state_name)
	._change_state(state_name)

func _on_noise_emmited(location, volume_range, priority):
	if current_state == $Attack:
		return
	if owner.global_position.distance_to(location) <= volume_range:
		var path = owner.navigation.get_simple_path(owner.global_position, location)
		if path.size() == 0:
			owner.look_at(location)
			return
		
		owner.player_last_pos = location
		
		if current_state == $Chase:
			if priority == 1 && !owner.can_see_player():
				$Chase.objective_path = path
			return
		
		if not current_state in [$Searching, $Chase]:
			_change_state("searching")
		$Searching.objective_path = path

