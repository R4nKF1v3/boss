extends Event
class_name FlickeringEvent

export (bool) var toggle_after_finish = false
export (Array, NodePath) var nodes = []
export (Array, float) var timings = []
export (float) var duration = 1

func handle():
	if !(one_shot && was_emmited) && nodes.size() > 0:
		was_emmited = true
		var event = WorldEvents.event_types.Flickering.new()
		event.timings = timings
		event.duration = duration
		event.toggle_after_finish = toggle_after_finish
		for path in nodes:
			var node = get_node(path)
			if node && node.has_method("handle_world_event"):
				node.handle_world_event(WorldEvents.event_types.Flickering, event)