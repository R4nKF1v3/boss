extends VisibleEnemy

export (float) var DETECTION_RANGE = 800
export (float) var FOV = 90
export (float) var MELEE_DAMAGE = 3
export (float) var INSANITY_DAMAGE = 3

onready var navigation : TileMap
onready var raycast : RayCast2D = $DetectionRay

var target
var player_last_pos
var look_at = Vector2(1,0)
var curr_vel = Vector2()
var damage_receiver

signal new_path(path)

func _ready():
	var shape = CircleShape2D.new()
	shape.radius = DETECTION_RANGE
	$DetectionArea/CollisionShape2D.shape = shape
	$DetectionArea.connect("body_entered", self, "on_detection_body_entered")
	$DetectionArea.connect("body_exited", self, "on_detection_body_exited")
	$DamageArea.connect("body_entered", self, "on_damage_body_entered")
	$DamageArea.connect("body_exited", self, "on_damage_body_exited")

func _integrate_forces(state):
	state.linear_velocity = curr_vel
	var target = (look_at - global_position).normalized()
	state.angular_velocity = (lerp_angle(rotation, target.angle(), 3) - rotation)
	
	if damage_receiver:
		damage_receiver.take_damage(MELEE_DAMAGE, "hp")


func lerp_angle(from, to, weight):
	return from + short_angle_dist(from, to) * weight

func short_angle_dist(from, to):
	var max_angle = PI * 2
	var difference = fmod(to - from, max_angle)
	return fmod(2 * difference, max_angle) - difference
	

func can_see_player() -> bool:
	if target:
		var direction_to_node = (target.global_position - global_position).normalized()
		if abs(rad2deg(Vector2(1,0).rotated(rotation).angle_to(direction_to_node))) < FOV:
			var space_state = get_world_2d().direct_space_state
			
			#var target_extents = target.get_node("CollisionShape2D").shape.extents
			#var nw = target.global_position - target_extents
			#var se = target.global_position + target_extents
			#var ne = target.global_position + Vector2(target_extents.x, -target_extents.y)
			#var sw = target.global_position + Vector2(-target_extents.x, target_extents.y)
			#for pos in [target.global_position, nw, se, ne, sw]:
			#	var result = space_state.intersect_ray(global_position, pos, [self], collision_mask)
			#	var response = result and result.collider == target
			#	if response:
			#		player_last_pos = target.global_position
			#		return true
			
			raycast.global_position = global_position
			raycast.cast_to = raycast.to_local(target.global_position)
			raycast.force_raycast_update()
			var result = raycast.get_collider()
			var response = result && result == target
			if response:
				player_last_pos = target.global_position
				return true
	return false

func can_reach_player():
	return target && navigation.is_valid_node(target.global_position)

func deal_insanity_damage():
	PlayerStatus.take_damage(INSANITY_DAMAGE, "insanity")

func on_detection_body_entered(body):
	if body is Player:
		target = body

func on_detection_body_exited(body):
	if target and target == body:
		target = null

func on_damage_body_entered(body):
	if body is Player:
		damage_receiver = body

func on_damage_body_exited(body):
	if damage_receiver and damage_receiver == body:
		damage_receiver = null

