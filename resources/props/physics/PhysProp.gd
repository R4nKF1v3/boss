extends InteractuableElement

export (Texture) var on_toggle_hidden_texture
export (Texture) var on_toggle_visible_texture
export (bool) var on_toggle_mode_switch_static = false
export (bool) var on_toggle_collision_switch = false

onready var hidden = $TextureProp/Hidden
onready var vis = $TextureProp/Visible
onready var prop = $PhysProp

onready var hidden_base_tx = hidden.texture
onready var vis_base_tx = vis.texture
onready var prop_coll = [prop.collision_layer, prop.collision_mask]

func get_interaction_area():
	return $PhysProp/InteractionArea

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
	
	if on_toggle_collision_switch && prop.collision_layer != 20 && prop.collision_mask != 20:
		prop.collision_layer = 20
		prop.collision_mask = 20
	elif prop.collision_layer != prop_coll[0] && prop.collision_mask != prop_coll[1]:
		prop.collision_layer = prop_coll[0]
		prop.collision_mask = prop_coll[1]