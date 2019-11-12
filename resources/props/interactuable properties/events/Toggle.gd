extends Event
class_name ToggleEvent

static func handle(emmiter):
	if !(emmiter.toggle_event_one_shot && emmiter.was_emmited):
		var event_group = emmiter.toggle_event_nodes
		if event_group.size() > 0:
			var event = WorldEvents.event_types.Toggle.new()
			for path in event_group:
				var node = emmiter.get_node(path)
				if node && node.has_method("handle_world_event"):
					node.handle_world_event(WorldEvents.event_types.Toggle, event)