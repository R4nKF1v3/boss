extends Event
class_name ToggleEvent

export (Array, NodePath) var nodes = []

func handle():
	if time_until_activation > 0:
		yield(get_tree().create_timer(time_until_activation), "timeout")
	if !(one_shot && was_emmited) && nodes.size() > 0:
		was_emmited = true
		var event = WorldEvents.event_types.Toggle.new()
		for path in nodes:
			var node = get_node(path)
			if node && node.has_method("handle_world_event"):
				node.handle_world_event(WorldEvents.event_types.Toggle, event)