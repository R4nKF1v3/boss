extends Position2D

const POINTER_LIMIT = 100

onready var player: Player = get_parent().get_node("Player")
onready var camera_offset = $CameraOffset

var target : Vector2 = Vector2.ZERO
var weight = 0.05

func _ready():
	var viewport_rect = get_viewport_rect()
	var shape = RectangleShape2D.new()
	shape.extents = viewport_rect.size/2
	$CameraOffset/Camera2D/EnemyVisibleArea/CollisionShape2D.shape = shape
	$CameraOffset/Camera2D/EnemyVisibleArea.connect("body_entered", self, "on_body_entered_visible_area")
	$CameraOffset/Camera2D/EnemyVisibleArea.connect("body_exited", self, "on_body_exited_visible_area")
	

func _physics_process(delta):
	position = player.position
	camera_offset.position = lerp(camera_offset.position, target, weight)

func _input(event):
	if event is InputEventMouseMotion:
		_update_target(get_local_mouse_position())

func _update_target(mouse_pos):
	target = mouse_pos.clamped(POINTER_LIMIT)

func on_body_entered_visible_area(body):
	player.body_entered_visible_area(body)

func on_body_exited_visible_area(body):
	player.body_exited_visible_area(body)
