extends InteractuableElement

export (bool) var door_is_closed = true
export (bool) var door_is_locked = false
export (Vector2) var force_when_opened = Vector2()
export (int) var hits_until_open = -1
export (Array, String) var message_when_locked = ["Está cerrada",]

var dialogue
var nearby_entities : Array = []

func _ready():
	inter_area = $Door/Doorway/InteractionArea
	var shape = CircleShape2D.new()
	shape.radius = 135
	$Door/DetectionArea/CollisionShape2D.shape = shape
	$Door/DetectionArea.connect("body_entered", self, "on_body_entered")
	$Door/DetectionArea.connect("body_exited", self, "on_body_exited")
	if door_is_closed:
		$Door/Doorway.locked = true
	if message_when_locked.size()>0:
		dialogue = DialogueEvent.new()
		dialogue.is_sucessive = true
		dialogue.dialogue_text = message_when_locked
		

func get_interaction_area():
	return $Door/Doorway/InteractionArea

func get_collision_body():
	return $Door/Doorway

func get_global_position() -> Vector2:
	return $Door/Doorway.global_position

func handle_event(event: InputEvent):
	if can_handle_event(event):
		get_tree().set_input_as_handled()
		if !door_is_locked:
			toggle()
			trigger_events()
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
	toggled = !toggled

func lock_door():
	$Door/Doorway.locked = true
	$Door/Doorway/LockSound.play()

func unlock_door():
	$Door/Doorway.locked = false
	var force = determineForce()
	$Door/Doorway.linear_velocity = force
	$Door/Doorway/LockSound.play()

func send_locked_message():
	if dialogue:
		dialogue.handle()

func determineForce():
	if nearby_entities.size() > 0:
		var ret_entity = nearby_entities[0]
		var distance = 80
		var door_pos = $Door/Doorway.global_position
		for entity in nearby_entities:
			var this_distance = door_pos.distance_to(entity.global_position)
			if this_distance < distance:
				ret_entity = entity
				distance = this_distance
		return (door_pos - ret_entity.global_position).normalized() * 60
	else:
		return force_when_opened

func on_body_entered(body):
	if body is Player || body is NPC:
		nearby_entities.push_front(body)

func on_body_exited(body):
	if body in nearby_entities:
		nearby_entities.remove(nearby_entities.find(body))