extends "res://entities/state_machine.gd"

func _ready():
	states_map = {
		"idle": $Idle,
		"wander": $Wander,
		"chase": $Chase,
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

func _on_noise_emmited(location):
	if owner.global_position.distance_to(location) < owner.HEARING_RANGE:
		if current_state in [$Idle, $Wander]:
			_change_state("chase")
		if not owner.can_see_player():
			$Chase.objective_path = owner.navigation2D.get_simple_path(owner.global_position, location)