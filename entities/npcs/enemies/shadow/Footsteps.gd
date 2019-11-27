extends AudioStreamPlayer2D

export (String) var bus_behind_walls = "Muffled Footsteps"
export (String) var base_bus = "Footsteps"

func play(from_position=0.0):
	var plpos = PlayerStatus.get_global_position()
	var world = get_world_2d()
	if world && WorldEvents.check_behind_wall(self, plpos, world.direct_space_state):
		if bus != bus_behind_walls:
			bus = bus_behind_walls
	else:
		if bus != base_bus:
			bus = base_bus
	.play(from_position)