extends RigidBody2D

var reset = false

var start_angle

func _ready():
	start_angle = global_rotation

func _integrate_forces(state):
	if reset:
		state.transform = Transform2D(start_angle, state.transform.origin)
		state.linear_velocity = Vector2()
		state.angular_velocity = 0
