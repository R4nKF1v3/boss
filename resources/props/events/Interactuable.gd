extends Node2D
class_name InteractuableEvent

export (bool) var is_interactuable : bool = false
export (Texture) var mouse_texture : Texture = preload("res://resources/cursors/cursor-selecting.png")

func _ready():
	pass

func handle_event(event: InputEvent):
	if can_handle_event(event):
		pass

func can_handle_event(event: InputEvent):
	return event.is_action_pressed("interact")

func get_mouse_texture():
	return mouse_texture

func get_global_position() -> Vector2:
	return get_child(0).global_position