extends Node

var event_types = {
	"Toggle": ToggleEvent,
	"Flickering": FlickeringEvent,
	"Canvas": CanvasEvent,
	"Dialogue": DialogueEvent,
	"TogInteractuable": TogInteractuable,
}

signal change_canvas_color(color)
signal new_player_dialogue(dialogue)