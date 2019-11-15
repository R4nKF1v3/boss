extends Node2D
class_name InteractuableElement

# Interaction tooltips
export (bool) var is_interactuable = false
export (bool) var delete_on_interaction = false
export (bool) var delete_on_tog_interactuable_event = false
export (bool) var trigger_on_toggle_event = false
export (Texture) var mouse_texture : Texture = preload("res://resources/cursors/cursor-selecting.png")

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
var timer_list = []
var timer_index = 0
var toggle_after_finish = false


func handle_event(event: InputEvent):
	if can_handle_event(event):
		print("Handling event")
		print(name)
		get_tree().set_input_as_handled()
		
		trigger_events()

func trigger_events():
	for eventType in WorldEvents.event_types.values():
		eventType.handle(self)
	
	if delete_on_interaction:
		self.queue_free()
	was_emmited = true

func can_handle_event(event: InputEvent):
	return event.is_action_pressed("interact")

func get_global_position() -> Vector2:
	return get_child(0).global_position

func get_interaction_area():
	return null

func handle_world_event(eventType, event):
	match eventType:
		WorldEvents.event_types.Toggle:
			if trigger_on_toggle_event:
				trigger_events()
			else:
				toggle()
		
		WorldEvents.event_types.TogInteractuable:
			togInteract()
			
		WorldEvents.event_types.Flickering:
			flicker(event)

func update_timer_index():
	timer_index = timer_index + 1 if timer_index + 1 <= timer_list.size() - 1 else 0

func reset_timers():
	if has_node("DurationTimer"):
		var n = get_node("DurationTimer")
		remove_child(n)
		n.queue_free()
	if has_node("Timer"):
		var n = get_node("Timer")
		remove_child(n)
		n.queue_free()
	
	timer_index = 0

func togInteract():
	if delete_on_tog_interactuable_event:
		self.queue_free()
	else:
		is_interactuable = !is_interactuable

func flicker(event):
	reset_timers()
	
	timer_list = event.timings
	toggle_after_finish = event.toggle_after_finish
	
	var duration_timer = Timer.new()
	duration_timer.name = "DurationTimer"
	duration_timer.one_shot = true
	duration_timer.connect("timeout", self, "_on_event_duration_timer_timeout")
	
	var timer = Timer.new()
	timer.name = "Timer"
	timer.one_shot = true
	timer.connect("timeout", self, "_on_event_timer_timeout")
	
	add_child(duration_timer)
	add_child(timer)
	
	if event.duration:
		duration_timer.start(event.duration)
	if timer_list.size() > 0:
		timer.start(timer_list[timer_index])
		update_timer_index()

func _on_event_timer_timeout():
	toggle()
	var timer = get_node("Timer")
	timer.start(timer_list[timer_index])
	update_timer_index()

func _on_event_duration_timer_timeout():
	if timer_index % 2 == 0 && timer_list.size() > 0:
		toggle()
	reset_timers()
	if toggle_after_finish:
		toggle()

func toggle():
	pass