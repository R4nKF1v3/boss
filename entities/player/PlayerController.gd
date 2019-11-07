extends RigidBody2D

class_name Player

const FOV = 40

onready var camera_pointer = get_parent().get_node("CameraPointer")
onready var raycast : RayCast2D = $DetectionRay

var look_direction : = Vector2(1, 0)
var current_velocity : = Vector2()
var camera_follow = true
var enemies_in_proximity := []


func _integrate_forces(state):
	state.linear_velocity = current_velocity
	
	var target : Vector2
	var weight : float
	if camera_follow:
		target = camera_pointer.camera_offset.global_position - global_position
		weight = 3
	else:
		target = look_direction
		weight = 4
	
	state.angular_velocity = lerp_angle(rotation, target.angle(), weight) - rotation
	
	enemy_visible_check()

func lerp_angle(from, to, weight):
    return from + short_angle_dist(from, to) * weight

func short_angle_dist(from, to):
    var max_angle = PI * 2
    var difference = fmod(to - from, max_angle)
    return fmod(2 * difference, max_angle) - difference


func take_damage(amount, type):
	PlayerStatus.take_damage(amount, type)


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


func enemy_visible_check():
	if enemies_in_proximity:
		for enemy in enemies_in_proximity:
			var direction = (enemy.global_position - global_position)
			if abs(rad2deg(Vector2(1,0).rotated(rotation).angle_to(direction))) < FOV:
				var mask = $VisibilityRaycast.collision_mask
				var space_state = get_world_2d().direct_space_state
				var target_extents = enemy.get_node("CollisionShape2D").shape.extents
				var nw = enemy.global_position - target_extents
				var se = enemy.global_position + target_extents
				var ne = enemy.global_position + Vector2(target_extents.x, -target_extents.y)
				var sw = enemy.global_position + Vector2(-target_extents.x, target_extents.y)
				for pos in [enemy.global_position, nw, se, ne, sw]:
					raycast.global_position = global_position
					raycast.cast_to = raycast.to_local(pos)
					raycast.force_raycast_update()
					var result = raycast.get_collider()
					var response = result and result == enemy
					if response:
						enemy.deal_insanity_damage()
						return


func body_entered_visible_area(body):
	if body is VisibleEnemy:
		enemies_in_proximity.push_front(body)

func body_exited_visible_area(body):
	if body is VisibleEnemy && enemies_in_proximity.has(body):
		enemies_in_proximity.remove(enemies_in_proximity.find(body))





