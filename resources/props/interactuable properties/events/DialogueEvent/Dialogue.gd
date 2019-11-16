extends Event
class_name DialogueEvent

export (bool) var is_sucessive = false
export (Array, String) var dialogue_text = []

func handle():
	var dialogue = dialogue_text
	if !((one_shot && !(is_sucessive && dialogue.size() > 0)) && was_emmited):
		was_emmited = true
		if dialogue.size() > 0 && is_sucessive:
			WorldEvents.emit_signal("new_player_dialogue", [dialogue[0]])
			if one_shot:
				dialogue_text.pop_front()
			else:
				dialogue_text.push_back(dialogue.pop_front())
		else:
			WorldEvents.emit_signal("new_player_dialogue", dialogue)