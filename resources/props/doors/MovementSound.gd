extends AudioStreamPlayer2D

export (String) var bus_behind_walls = "Muffled Environment"
export (String) var base_bus = "Environment"

onready var prop = get_parent()
onready var timer = $Timer

func _ready():
	timer.connect("timeout", self, "on_timer_timeout")
	timer.start(2)

func on_timer_timeout():
	call_deferred("do_check")

func do_check():
	var mov = (prop.linear_velocity.length() + abs(prop.angular_velocity)) > 0.1
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
	timer.start(2)