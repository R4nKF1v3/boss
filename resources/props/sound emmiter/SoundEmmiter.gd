extends AudioStreamPlayer2D

export (String) var bus_behind_walls = "Muffled Environment"
export (String) var base_bus = "Environment"

export (float) var sound_range = 0
export (int) var sound_priority = 2

func _ready():
	set_process(false)

func handle_world_event(eventType, event):
	match eventType:
		WorldEvents.event_types.Trigger:
			if event.wait_time > 0:
				var timer = Timer.new()
				timer.name = "TriggerTimer"
				add_child(timer)
				timer.start(event.wait_time)
				yield(timer, "timeout")
				remove_child(timer)
				timer.queue_free()
			trigger_player()

func trigger_player():
	if playing:
		stop()
		set_process(false)
	else:
		check_bus()
		play()
		set_process(true)
		

func _process(delta):
	if playing:
		check_bus()
	else:
		set_process(false)

func check_bus():
	if WorldEvents.check_behind_wall(self, PlayerStatus.get_global_position(), get_world_2d().direct_space_state):
		if bus != bus_behind_walls:
			bus = bus_behind_walls
	else:
		if bus != base_bus:
			bus = base_bus
	signals.emit_signal("noise_emitted", global_position, sound_range, sound_priority)