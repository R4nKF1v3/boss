extends Event
class_name CanvasEvent

# Canvas event
export (Color) var color = World_Properties.canvas_default

func handle():
	if time_until_activation > 0:
		yield(get_tree().create_timer(time_until_activation), "timeout")
	if !(one_shot && was_emmited):
		was_emmited = true
		WorldEvents.emit_signal("change_canvas_color", color)