extends "res://entities/state.gd"

func enter():
	print("Entered Retire")
	owner.player_last_pos = null
	owner.curr_vel = get_coll_normal()*500
	owner.get_node("AnimationPlayer").play("idle")

func update(delta):
	var coll_normal = get_coll_normal()
	if coll_normal != Vector2():
		owner.curr_vel = coll_normal * 500
	else:
		emit_signal("finished", "idle")

func get_coll_normal():
	var coll = owner.get_colliding_bodies()
	if coll:
		for el in coll:
			if el is Door && el.locked:
				return (owner.global_position - el.global_position).normalized()
	return Vector2()