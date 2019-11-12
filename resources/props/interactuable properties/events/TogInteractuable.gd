extends Event
class_name TogInteractuable

static func handle(emmiter):
	if !(emmiter.tog_interactuable_event_one_shot && emmiter.was_emmited):
		var event_group = emmiter.tog_interactuable_event_nodes
		if event_group.size() > 0:
			var event = WorldEvents.event_types.TogInteractuable.new()
			for path in event_group:
				var node = emmiter.get_node(path)
				if node && node.has_method("handle_world_event"):
					node.handle_world_event(WorldEvents.event_types.TogInteractuable, event)