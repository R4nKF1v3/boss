extends Node2D
class_name TriggerArea

export (bool) var is_interactuable = true
export (bool) var delete_on_interaction = false

var was_emmited = false

func _ready():
	$Area.connect("body_entered", self, "on_body_entered")

func handle_world_event(eventType, event):
	match eventType:
		WorldEvents.event_types.TogInteractuable:
			is_interactuable = !is_interactuable
		
		WorldEvents.event_types.Trigger:
			if event.wait_time > 0:
				var timer = Timer.new()
				timer.name = "TriggerTimer"
				add_child(timer)
				timer.start(event.wait_time)
				yield(timer, "timeout")
				remove_child(timer)
				timer.queue_free()
			trigger_events()

func on_body_entered(body):
	if !is_interactuable:
		return
	if body is Player:
		print("Player triggered")
		
		trigger_events()
	
		if delete_on_interaction:
			self.queue_free()
		was_emmited = true

func trigger_events():
	var children = get_children()
	for child in children:
		if child is Event:
			child.handle()