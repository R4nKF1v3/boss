extends "res://entities/state.gd"

var velocity = Vector2()

func _ready():
	parent = owner.get_node("Player")

func handle_input(event):
#	if event.is_action_pressed("simulate_damage"):
#		emit_signal("finished", "stagger")
	pass


func get_input_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input_direction

func update_look_direction(direction):
	if direction and parent.look_direction != direction:
		parent.look_direction = direction
