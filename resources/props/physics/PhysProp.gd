extends InteractuableElement

export (bool) var starts_toggled = false
export (Texture) var on_toggle_hidden_texture
export (Texture) var on_toggle_visible_texture
export (bool) var on_toggle_mode_switch_static = false
export (bool) var on_toggle_collision_switch = false

onready var hidden = $PhysProp/Hidden
onready var vis = $PhysProp/Visible
onready var prop = $PhysProp

var hidden_base_tx
var vis_base_tx
var prop_coll

func _ready():
	inter_area = $PhysProp/InteractionArea
	hidden_base_tx = hidden.texture
	vis_base_tx = vis.texture
	prop_coll = [prop.collision_layer, prop.collision_mask]
	if starts_toggled:
		toggle()

func get_global_position() -> Vector2:
	return $PhysProp.global_position

func get_interaction_area():
	return $PhysProp/InteractionArea

func get_collision_body():
	return $PhysProp

func toggle():
	if hidden.texture != on_toggle_hidden_texture:
		hidden.texture = on_toggle_hidden_texture
	elif hidden.texture != hidden_base_tx:
		hidden.texture = hidden_base_tx
	
	if vis.texture != on_toggle_visible_texture:
		vis.texture = on_toggle_visible_texture
	elif vis.texture != vis_base_tx:
		vis.texture = vis_base_tx
	
	if on_toggle_mode_switch_static && prop.mode != RigidBody2D.MODE_STATIC:
		prop.mode = RigidBody2D.MODE_STATIC
	elif prop.mode != RigidBody2D.MODE_RIGID:
		prop.mode = RigidBody2D.MODE_RIGID
	
	if on_toggle_collision_switch && prop.collision_layer == prop_coll[0] && prop.collision_mask == prop_coll[1]:
		prop.collision_layer = 262144
		prop.collision_mask = 262144
	elif prop.collision_layer != prop_coll[0] && prop.collision_mask != prop_coll[1]:
		prop.collision_layer = prop_coll[0]
		prop.collision_mask = prop_coll[1]
	toggled = !toggled