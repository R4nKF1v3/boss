extends Event
class_name CanvasEvent

static func handle(emmiter):
	if !(emmiter.canvas_event_one_shot && emmiter.was_emmited) && emmiter.canvas_event_color != World_Properties.canvas_default:
		WorldEvents.emit_signal("change_canvas_color", emmiter.canvas_event_color)