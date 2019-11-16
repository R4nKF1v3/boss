extends AudioStreamPlayer2D

onready var prop = get_parent()

func _process(delta):
	var mov = prop.linear_velocity.length() > 0
	var ang_mov = prop.angular_velocity != 0
	print(prop.linear_velocity.length())
	print(mov)
	print(prop.angular_velocity)
	print(ang_mov)
	print(playing)
	if mov || ang_mov:
		#if WorldEvents.check_behind_wall(self, PlayerStatus.get_global_position(), get_world_2d().direct_space_state) && bus != "muffled":
		#	bus = "muffled"
		#elif bus != "Master":
		#	bus = "Master"
		if !playing:
			play()
	elif playing:
		stop()