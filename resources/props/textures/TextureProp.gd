extends InteractuableElement

export (Texture) var on_toggle_hidden_texture
export (Texture) var on_toggle_visible_texture

onready var hidden = $TextureProp/Hidden
onready var vis = $TextureProp/Visible

onready var hidden_base_tx = hidden.texture
onready var vis_base_tx = vis.texture

func get_interaction_area():
	return $TextureProp/InteractionArea

func toggle():
	if hidden.texture != on_toggle_hidden_texture:
		hidden.texture = on_toggle_hidden_texture
	elif hidden.texture != hidden_base_tx:
		hidden.texture = hidden_base_tx
	
	if vis.texture != on_toggle_visible_texture:
		vis.texture = on_toggle_visible_texture
	elif vis.texture != vis_base_tx:
		vis.texture = vis_base_tx
	