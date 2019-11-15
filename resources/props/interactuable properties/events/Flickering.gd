extends Event
class_name FlickeringEvent

var timings
var duration
var toggle_after_finish

static func handle(emmiter):
	if !(emmiter.flickering_event_one_shot && emmiter.was_emmited):
		var event_group = emmiter.flickering_event_nodes
		if event_group.size() > 0:
			var event = WorldEvents.event_types.Flickering.new()
			event.timings = emmiter.flickering_event_timings
			event.duration = emmiter.flickering_event_duration
			event.toggle_after_finish = emmiter.flickering_event_toggle_after_finish
			for path in event_group:
				var node = emmiter.get_node(path)
				if node && node.has_method("handle_world_event"):
					node.handle_world_event(WorldEvents.event_types.Flickering, event)
