extends InteractuableElement

export (Texture) var on_toggle_hidden_texture
export (Texture) var on_toggle_visible_texture
export (bool) var on_toggle_collision_switch = false

onready var hidden = $StaticProp/Hidden
onready var vis = $StaticProp/Visible
onready var prop = $StaticProp

onready var hidden_base_tx = hidden.texture
onready var vis_base_tx = vis.texture
onready var prop_coll = [prop.collision_layer, prop.collision_mask]

func get_interaction_area():
	return $StaticProp/InteractionArea

func get_global_position() -> Vector2:
	return prop.global_position

func toggle():
	if hidden.texture != on_toggle_hidden_texture:
		hidden.texture = on_toggle_hidden_texture
	elif hidden.texture != hidden_base_tx:
		hidden.texture = hidden_base_tx
	
	if vis.texture != on_toggle_visible_texture:
		vis.texture = on_toggle_visible_texture
	elif vis.texture != vis_base_tx:
		vis.texture = vis_base_tx
	
	if on_toggle_collision_switch && prop.collision_layer != 20 && prop.collision_mask != 20:
		prop.collision_layer = 20
		prop.collision_mask = 20
	elif prop.collision_layer != prop_coll[0] && prop.collision_mask != prop_coll[1]:
		prop.collision_layer = prop_coll[0]
		prop.collision_mask = prop_coll[1]