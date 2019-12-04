extends Event
class_name ShowShiftEvent

func _ready():
	one_shot = true

func handle():
	if time_until_activation > 0:
		yield(get_tree().create_timer(time_until_activation), "timeout")
	if !(one_shot && was_emmited):
		was_emmited = true
		WorldEvents.emit_signal("show_shift")