extends "res://entities/state.gd"

var target
# Initialize the state. E.g. change the animation
func enter():
	var coll = owner.get_colliding_bodies()
	if coll:
		for el in coll:
			if el is Door:
				target = el
				owner.curr_vel = Vector2()
				owner.look_at = target.global_position
				owner.get_node("AnimationPlayer").play("attack")
				return
	emit_signal("finished", "previous")

# Clean up the state. Reinitialize values like a timer
func exit():
	target = null

func _on_animation_finished(anim_name):
	if anim_name == "attack":
		var result = target.receive_damage()
		print("Attacked door")
		if result:
			emit_signal("finished", "previous")
		else:
			owner.get_node("AnimationPlayer").play("attack")
	
