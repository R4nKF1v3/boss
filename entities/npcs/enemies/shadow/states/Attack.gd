extends "res://entities/state.gd"

export (int) var attack_times = 8

var target
var times_attacked = 0
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
		times_attacked += 1
		print("Attacked door")
		if result:
			times_attacked = 0
			emit_signal("finished", "previous")
		elif times_attacked == attack_times:
			times_attacked = 0
			print("Going to idle")
			emit_signal("finished", "prev_idle")
		else:
			owner.get_node("AnimationPlayer").play("attack")
	
