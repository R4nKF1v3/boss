extends Event
class_name FlickeringEvent

var timings
var duration
var toggle_after_finish

static func handle(emmiter: InteractuableElement):
	if !(emmiter.flickering_event_one_shot && emmiter.was_emmited):
		var event_group = emmiter.flickering_event_nodes
		if event_group.size() > 0:
			var event = WorldEvents.event_types.Flickering.new()
			event.timings = calculate_timings(emmiter.flickering_event_timings)
			event.duration = emmiter.flickering_event_duration
			event.toggle_after_finish = emmiter.flickering_event_toggle_after_finish
			for node in event_group:
				node.handle_world_event(WorldEvents.event_types.Flickering, event)

static func calculate_timings(timings_list) -> Array:
	if timings_list:
		var ret_list = []
		for time in timings_list:
			ret_list.push_front(time/2)
			ret_list.push_front(time/2)
		return ret_list
	else:
		return [0.1, 0.1]