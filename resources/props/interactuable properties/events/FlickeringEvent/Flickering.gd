extends Event
class_name FlickeringEvent

export (bool) var toggle_after_finish = false
export (Array, NodePath) var nodes = []
export (Array, float) var timings = []
export (float) var duration = 0

func handle():
	if time_until_activation > 0:
		yield(get_tree().create_timer(time_until_activation), "timeout")
	if !(one_shot && was_emmited) && nodes.size() > 0:
		was_emmited = true
		var event = WorldEvents.event_types.Flickering.new()
		event.timings = timings
		if duration > 0:
			event.duration = duration
		event.toggle_after_finish = toggle_after_finish
		for path in nodes:
			var node = get_node(path)
			if node && node.has_method("handle_world_event"):
				node.handle_world_event(WorldEvents.event_types.Flickering, event)
