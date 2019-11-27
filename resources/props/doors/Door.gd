extends InteractuableElement

export (bool) var door_is_closed = true
export (bool) var door_is_locked = false
export (int) var hits_until_open = -1
export (Array, String) var message_when_locked = ["Está cerrada",]

var dialogue

func _ready():
	if door_is_closed:
		$Door/Doorway.locked = true
	if message_when_locked.size()>0:
		dialogue = DialogueEvent.new()
		dialogue.is_sucessive = true
		dialogue.dialogue_text = message_when_locked
		

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
		if !door_is_locked:
			toggle()
		else:
			send_locked_message()

func togInteract():
	door_is_locked = !door_is_locked
	if !door_is_closed:
		door_is_closed = true
		lock_door()

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

func send_locked_message():
	if dialogue:
		dialogue.handle()
		