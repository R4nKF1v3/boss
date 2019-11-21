extends InteractuableElement

export (bool) var door_is_closed = true
export (int) var hits_until_open = -1

func _ready():
	if door_is_closed:
		$Door/Doorway.locked = true

func get_interaction_area():
	return $Door/Doorway/InteractionArea

func get_global_position() -> Vector2:
	return $Door/Doorway.global_position

func handle_event(event: InputEvent):
	if can_handle_event(event):
		print("Handling event")
		print(name)
		get_tree().set_input_as_handled()
		
		trigger_events()
		toggle()

func toggle():
	if door_is_closed:
		door_is_closed = false
		unlock_door()
	else:
		door_is_closed = true
		lock_door()

func lock_door():
	$Door/Doorway.locked = true
	$Door/Doorway/LockSound.play()

func unlock_door():
	$Door/Doorway.locked = false
	$Door/Doorway/LockSound.play()
