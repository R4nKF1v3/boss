extends AudioStreamPlayer2D

export (String) var bus_behind_walls = "Muffled Environment"
export (String) var base_bus = "Environment"

func play(from_position=0.0):
	if WorldEvents.check_behind_wall(self, PlayerStatus.get_global_position(), get_world_2d().direct_space_state):
		if bus != bus_behind_walls:
			bus = bus_behind_walls
	else:
		if bus != base_bus:
			bus = base_bus
	.play(from_position)