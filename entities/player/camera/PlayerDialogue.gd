extends Label

var current_dialogue_list = []
var curr_dialogue
var index = 0

func _ready():
	text = ""
	WorldEvents.connect("new_player_dialogue", self, "_on_new_player_dialogue")
	$Timer.connect("timeout", self, "_on_timer_timeout")

func _on_timer_timeout():
	if !curr_dialogue:
		if current_dialogue_list.size() == 0:
			text = ""
			return
		curr_dialogue = current_dialogue_list.pop_front()
	index += 1
	text = curr_dialogue.left(index)
	if text == curr_dialogue:
		curr_dialogue = null
		index = 0
		$Timer.start(5)
	else:
		$Timer.start(0.05)

func _on_new_player_dialogue(newDialogue):
	current_dialogue_list = newDialogue.duplicate()
	curr_dialogue = null
	index = 0 
	$Timer.start(0.1)
	