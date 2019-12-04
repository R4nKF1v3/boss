extends AudioStreamPlayer2D

var sound_list = []

func _ready():
	sound_list.push_front(preload("res://entities/player/sfx/footsteps/paso1.wav"))
	sound_list.push_front(preload("res://entities/player/sfx/footsteps/paso2.wav"))
	sound_list.push_front(preload("res://entities/player/sfx/footsteps/paso3.wav"))
	sound_list.push_front(preload("res://entities/player/sfx/footsteps/paso4.wav"))
	sound_list.push_front(preload("res://entities/player/sfx/footsteps/paso5.wav"))

func play(from_position=0.0):
	var sound = sound_list.pop_front()
	sound_list.push_back(sound)
	stream = sound
	.play(from_position)