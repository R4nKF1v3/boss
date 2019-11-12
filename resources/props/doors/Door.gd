extends InteractuableElement

export (bool) var door_is_locked = false

func _ready():
	if door_is_locked:
		lock_door()

func get_interaction_area():
	return $Door/Doorway/InteractionArea

func get_global_position() -> Vector2:
	return $Door/Doorway.global_position

func toggle():
	if door_is_locked:
		door_is_locked = false
		unlock_door()
	else:
		door_is_locked = true
		lock_door()

func lock_door():
	$Door/Doorway.reset = true

func unlock_door():
	$Door/Doorway.reset = false
