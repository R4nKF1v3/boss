extends "res://entities/state.gd"

export (float) var SPEED

var objective_path : = []

func travel_to_objective(delta):	
	var distance = SPEED * delta
	var start_point = owner.global_position
	for i in range(objective_path.size()):
		var distance_to_next = owner.global_position.distance_to(objective_path[0])
		if distance <= distance_to_next and distance >= 0.0:
			var direction_to_node = (objective_path[0] - owner.global_position).normalized()
			owner.rotation = direction_to_node.angle()
			var v = direction_to_node * SPEED
			owner.move_and_slide(v)
			break
		if distance < 0.0:
			break
		
		var direction_to_node = (objective_path[0] - owner.global_position).normalized()
		owner.rotation = direction_to_node.angle()
		var v = direction_to_node * SPEED
		owner.move_and_slide(v)
		distance -= distance_to_next
		objective_path.remove(0)
	
	


