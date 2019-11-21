extends RigidBody2D
class_name Door

var locked = false
var total_hits = 0

var start_angle
var start_position

func _ready():
	start_angle = global_rotation
	start_position = global_position

func _integrate_forces(state):
	if locked:
		state.transform = Transform2D(start_angle, start_position)
		state.linear_velocity = Vector2()
		state.angular_velocity = 0

func receive_damage():
	total_hits += 1
	$DamageSound.play()
	if total_hits == owner.hits_until_open:
		owner.toggle()
		total_hits = 0
		return true
	return false