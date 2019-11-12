extends Node2D
class_name TriggerArea

# Interaction tooltips
export (bool) var is_interactuable = false
export (bool) var delete_on_interaction = false

# Toggle event
export (bool) var toggle_event_one_shot = false
export (Array, NodePath) var toggle_event_nodes = []

# Toggle Interactuable event
export (bool) var tog_interactuable_event_one_shot = false
export (Array, NodePath) var tog_interactuable_event_nodes = []

# Flickering event
export (bool) var flickering_event_one_shot = false
export (bool) var flickering_event_toggle_after_finish = false
export (Array, NodePath) var flickering_event_nodes = []
export (Array, float) var flickering_event_timings = []
export (float) var flickering_event_duration = 1

# Canvas event
export (bool) var canvas_event_one_shot = false
export (Color) var canvas_event_color = World_Properties.canvas_default

# Dialogue event
export (bool) var dialogue_event_one_shot = false
export (bool) var dialogue_event_is_sucessive = false
export (Array, String) var dialogue_event_text = []

var was_emmited = false

func _ready():
	$Area.connect("body_entered", self, "on_body_entered")

func on_body_entered(body):
	if body is Player:
		print("Player triggered")
		
		for eventType in WorldEvents.event_types.values():
			eventType.handle(self)
		
		if delete_on_interaction:
			self.queue_free()
		was_emmited = true