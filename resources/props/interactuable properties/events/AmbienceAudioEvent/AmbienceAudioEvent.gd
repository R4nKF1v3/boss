extends Event
class_name AmbienceAudioEvent

export (AudioStream) var sound
export (float) var db_level = 0
export (String, "Replace Main", "Add to Background", "Remove Audio") var type = "Replace Main"
export (String) var bus = "Ambience"

func handle():
	if time_until_activation > 0:
		yield(get_tree().create_timer(time_until_activation), "timeout")
	if !(one_shot && was_emmited) && sound:
		was_emmited = true
		var event = WorldEvents.event_types.AmbienceAudio.new()
		event.sound = sound
		event.type = type
		event.bus = bus if bus else "Ambience"
		event.db_level = db_level
		
		AudioManager.handle(event)
