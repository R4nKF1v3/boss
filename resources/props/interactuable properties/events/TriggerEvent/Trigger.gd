extends Event
class_name TriggerEvent

export (float) var wait_time = 0
export (Array, NodePath) var nodes = []

func handle():
	if time_until_activation > 0:
		yield(get_tree().create_timer(time_until_activation), "timeout")
	if !(one_shot && was_emmited) && nodes.size() > 0:
		was_emmited = true
		var event = WorldEvents.event_types.Trigger.new()
		event.wait_time = wait_time
		for path in nodes:
			var node = get_node(path)
			if node && node.has_method("handle_world_event"):
				node.handle_world_event(WorldEvents.event_types.Trigger, event)