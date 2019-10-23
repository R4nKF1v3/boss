extends RigidBody2D

var look_direction : = Vector2(1, 0)
var current_velocity : = Vector2()
var camera_follow = true

onready var camera_pointer = get_parent().get_node("CameraPointer")

func _integrate_forces(state):
	state.linear_velocity = current_velocity
	
	if camera_follow:
		var camera_target = (camera_pointer.camera_offset.global_position - global_position).normalized()
		state.angular_velocity = (lerp_angle(rotation, camera_target.angle(), 0.1) - rotation) * 200
	else:
		state.angular_velocity = (lerp_angle(rotation, look_direction.angle(), 0.1) - rotation) * 200

func lerp_angle(from, to, weight):
    return from + short_angle_dist(from, to) * weight

func short_angle_dist(from, to):
    var max_angle = PI * 2
    var difference = fmod(to - from, max_angle)
    return fmod(2 * difference, max_angle) - difference
	

func take_damage(attacker, amount, effect=null):
	"""
	No utilizado por el momento
	"""
	"""
	if self.is_a_parent_of(attacker):
		return
	$States/Stagger.knockback_direction = (attacker.global_position - global_position).normalized()
	$Health.take_damage(amount, effect)
	"""

func set_dead(value):
	"""
	No utilizado por el momento
	"""
	set_process_input(not value)
	set_physics_process(not value)
	$CollisionPolygon2D.disabled = value

func _execute_step(volume_range):
	signals.emit_signal("noise_emitted", global_position, volume_range)
	#signals.emit_signal("camera_shake", 0.2, 2, 8, 1)