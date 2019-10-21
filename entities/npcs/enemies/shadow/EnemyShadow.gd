extends NPC

export (float) var DETECTION_RANGE = 800
export (float) var FOV = 90

onready var navigation : TileMap = owner.get_node("Pathtiles")
var target
var player_last_pos

signal new_path(path)

func _ready():
	var shape = CircleShape2D.new()
	shape.radius = DETECTION_RANGE
	$DetectionArea/CollisionShape2D.shape = shape
	$DetectionArea.connect("body_entered", self, "on_body_entered")
	$DetectionArea.connect("body_exited", self, "on_body_exited")

func can_see_player() -> bool:
	if target:
		var direction_to_node = (target.global_position - global_position).normalized()
		if abs(rad2deg(Vector2(1,0).rotated(rotation).angle_to(direction_to_node))) < FOV:
			var space_state = get_world_2d().direct_space_state
			var target_extents = target.get_node("CollisionShape2D").shape.extents
			var nw = target.global_position - target_extents
			var se = target.global_position + target_extents
			var ne = target.global_position + Vector2(target_extents.x, -target_extents.y)
			var sw = target.global_position + Vector2(-target_extents.x, target_extents.y)
			for pos in [target.global_position, nw, se, ne, sw]:
				var result = space_state.intersect_ray(global_position, pos, [self], collision_mask)
				var response = result and result.collider == target
				if response:
					player_last_pos = target.global_position
					return true
	return false

func can_reach_player():
	return target and navigation.is_valid_node(target.global_position)

func on_body_entered(body):
	print("Body entered")
	print(body.name)
	if body.name == "Player":
		target = body

func on_body_exited(body):
	if target and target == body:
		target = null

