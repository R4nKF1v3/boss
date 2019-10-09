extends "res://entities/state_machine.gd"

func _ready():
	states_map = {
		"idle": $Idle,
		"wander": $Wander,
		"chase": $Chase,
	}
	START_STATE = $Idle

func _change_state(state_name):
	"""
	The base state_machine interface this node extends does most of the work
	"""
	if not _active:
		return
	._change_state(state_name)
