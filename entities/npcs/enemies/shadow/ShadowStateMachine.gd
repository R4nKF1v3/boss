extends "res://entities/state_machine.gd"

func _ready():
	states_map = {
		"idle": $Idle,
		"wander": $Wander,
		"chase": $Chase,
		"searching": $Searching,
	}
	START_STATE = $Idle
	signals.connect("noise_emitted", self, "_on_noise_emmited")

func _change_state(state_name):
	"""
	The base state_machine interface this node extends does most of the work
	"""
	if not _active:
		return
	._change_state(state_name)

func _on_noise_emmited(location, volume_range):
	if owner.global_position.distance_to(location) <= volume_range:
		var path = owner.navigation.get_simple_path(owner.global_position, location)
		if path.size() == 0:
			owner.look_at(location)
			return
		
		owner.player_last_pos = location
		
		if current_state == $Chase:
			$Chase.objective_path = path
			return
		
		if not current_state in [$Searching, $Chase]:
			_change_state("searching")
		$Searching.objective_path = path

