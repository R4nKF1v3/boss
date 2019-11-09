extends Event
class_name DialogueEvent

var dialogue_text

static func handle(emmiter : InteractuableElement):
	if !(emmiter.dialogue_event_one_shot && emmiter.was_emmited):
		var dialogue = emmiter.dialogue_event_text
		if dialogue.size() > 0:
			if emmiter.dialogue_event_is_sucessive:
				WorldEvents.emit_signal("new_player_dialogue", [dialogue[0]])
				emmiter.dialogue_event_text.push_back(dialogue.pop_front())
			else:
				WorldEvents.emit_signal("new_player_dialogue", dialogue)