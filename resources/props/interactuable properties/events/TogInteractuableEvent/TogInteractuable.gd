extends Event
class_name TogInteractuable

export (Array, NodePath) var nodes = []

func handle():
	if !(one_shot && was_emmited) && nodes.size() > 0:
		was_emmited = true
		var event = WorldEvents.event_types.TogInteractuable.new()
		for path in nodes:
			var node = get_node(path)
			if node && node.has_method("handle_world_event"):
				node.handle_world_event(WorldEvents.event_types.TogInteractuable, event)