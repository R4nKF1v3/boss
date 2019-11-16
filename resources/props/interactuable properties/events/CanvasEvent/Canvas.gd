extends Event
class_name CanvasEvent

# Canvas event
export (Color) var color = World_Properties.canvas_default

func handle():
	if !(one_shot && was_emmited):
		was_emmited = true
		WorldEvents.emit_signal("change_canvas_color", color)