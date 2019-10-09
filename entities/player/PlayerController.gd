extends KinematicBody2D

# warning-ignore:unused_class_variable
var look_direction = Vector2(1, 0)

onready var camera_pointer = get_parent().get_node("CameraPointer")

# warning-ignore:unused_argument
func _physics_process(delta):
	look_at(camera_pointer.camera_offset.global_position)

# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
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
