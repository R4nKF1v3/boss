extends AudioStreamPlayer2D

export (String) var bus_behind_walls = "Muffled Environment"
export (String) var base_bus = "Environment"

onready var prop = get_parent()

func _process(delta):
	var mov = (prop.linear_velocity.length() + abs(prop.angular_velocity)) > 0.01
	if mov:
		if !playing:
			if WorldEvents.check_behind_wall(self, PlayerStatus.get_global_position(), get_world_2d().direct_space_state):
				if bus != bus_behind_walls:
					bus = bus_behind_walls
			else:
				if bus != base_bus:
					bus = base_bus
			play()
	elif playing:
		stop()