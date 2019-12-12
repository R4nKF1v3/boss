extends RigidBody2D
class_name Door

var locked = false
var total_hits = 0
var static_flag = false

var start_angle
var start_position

func _ready():
	start_angle = global_rotation
	start_position = global_position
	can_sleep = locked

func _integrate_forces(state):
	if locked && mode == RigidBody2D.MODE_STATIC:
		return
	if !locked && static_flag:
		static_flag = false
		call_deferred("set_mode", RigidBody2D.MODE_RIGID)
	elif locked && mode != RigidBody2D.MODE_STATIC:
		state.transform = Transform2D(start_angle, start_position)
		state.linear_velocity = Vector2()
		state.angular_velocity = 0
		static_flag = true
	elif locked && static_flag:
		call_deferred("set_mode", RigidBody2D.MODE_STATIC)

func receive_damage():
	if !locked:
		total_hits = 0
		return true
	total_hits += 1
	$DamageSound.play()
	if total_hits == owner.hits_until_open:
		owner.toggle()
		total_hits = 0
		return true
	return false

func set_mode(value):
	mode = value
	can_sleep = locked
	sleeping = locked