extends "res://entities/state.gd"

export (float) var SPEED
onready var anim_player : AnimationPlayer = owner.get_node("AnimationPlayer")
var objective_path = [] setget set_objective_path

func exit():
	objective_path = []

func update(delta):
	var coll = owner.get_colliding_bodies()
	if coll:
		for el in coll:
			if el is Door && el.locked:
				emit_signal("finished", "attack")
				return true
	return false

func travel_to_objective(delta):	
	var distance = SPEED * delta
	var start_point = parent.global_position
	for i in range(objective_path.size()):
		var distance_to_next = parent.global_position.distance_to(objective_path[0])
		if distance <= distance_to_next and distance >= 0.0:
			parent.look_at = objective_path[0]
			var direction_to_node = (objective_path[0] - parent.global_position).normalized()
			var v = direction_to_node * SPEED
			parent.curr_vel = v
			break
		if distance < 0.0:
			parent.look_at = objective_path[0]
			break
		
		parent.look_at = objective_path[0]
		var direction_to_node = (objective_path[0] - parent.global_position).normalized()
		var v = direction_to_node * SPEED
		parent.curr_vel = v
		distance -= distance_to_next
		objective_path.remove(0)

func set_objective_path(value):
	if value.size() == 0:
		return
	if value[0] == parent.global_position:
		return
	value[0] = parent.global_position
	objective_path = value
	parent.emit_signal("new_path", value)


