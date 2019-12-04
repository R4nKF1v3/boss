extends Node

var event_types = {
	"Toggle": ToggleEvent,
	"Flickering": FlickeringEvent,
	"Canvas": CanvasEvent,
	"Dialogue": DialogueEvent,
	"TogInteractuable": TogInteractuable,
	"Trigger": TriggerEvent,
	"AmbienceAudio": AmbienceAudioEvent,
}

signal change_canvas_color(color)
signal new_player_dialogue(dialogue)
signal show_shift

func check_behind_wall(audio : AudioStreamPlayer2D, target : Vector2, space : Physics2DDirectSpaceState) -> bool:
	var result = space.intersect_ray(audio.global_position, target, [], 1)
	return !result.empty()