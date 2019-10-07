extends "res://entities/state_machine.gd"

func _ready():
	states_map = {
		"idle": $Idle,
		"walk": $Walk,
		"run": $Run,
	}
	START_STATE = $Idle

func _change_state(state_name):
	"""
	The base state_machine interface this node extends does most of the work
	"""
	if not _active:
		return
	._change_state(state_name)

func _input(event):
	"""
	Here we only handle input that can interrupt states, attacking in this case
	otherwise we let the state node handle it
	"""
	pass
