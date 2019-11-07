extends Node2D
class_name InteractuableEvent

export (bool) var is_interactuable = false
export (Texture) var mouse_texture : Texture = preload("res://resources/cursors/cursor-selecting.png")

var events_map = {}

func _ready():
	events_map = {
		"Toggle": ToggleEvent,
	}

func handle_event(event: InputEvent):
	if can_handle_event(event):
		print("Handling event")

func can_handle_event(event: InputEvent):
	return event.is_action_pressed("interact")

func get_global_position() -> Vector2:
	return get_child(0).global_position

func get_interaction_area():
	return null
