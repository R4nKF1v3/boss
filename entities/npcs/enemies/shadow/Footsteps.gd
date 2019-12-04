extends AudioStreamPlayer2D

export (String) var bus_behind_walls = "Muffled Footsteps"
export (String) var base_bus = "Footsteps"

var sound_list = []

func _ready():
	sound_list.push_front(preload("res://entities/npcs/enemies/shadow/sfxs/footsteps/paso1.wav"))
	sound_list.push_front(preload("res://entities/npcs/enemies/shadow/sfxs/footsteps/paso2.wav"))
	sound_list.push_front(preload("res://entities/npcs/enemies/shadow/sfxs/footsteps/paso3.wav"))
	sound_list.push_front(preload("res://entities/npcs/enemies/shadow/sfxs/footsteps/paso4.wav"))
	sound_list.push_front(preload("res://entities/npcs/enemies/shadow/sfxs/footsteps/paso5.wav"))

func play(from_position=0.0):
	var plpos = PlayerStatus.get_global_position()
	var world = get_world_2d()
	if world && WorldEvents.check_behind_wall(self, plpos, world.direct_space_state):
		if bus != bus_behind_walls:
			bus = bus_behind_walls
	else:
		if bus != base_bus:
			bus = base_bus
	var sound = sound_list.pop_front()
	sound_list.push_back(sound)
	stream = sound
	.play(from_position)