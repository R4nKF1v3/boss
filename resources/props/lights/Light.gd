extends InteractuableElement

export (Texture) var on_toggle_emmisive_texture
export (Texture) var on_toggle_effect_texture
export (Texture) var on_toggle_emmiter_texture

onready var emmisive = $Light/Emmisive
onready var effect = $Light/Effect
onready var emmiter = $Light/Emmiter

onready var emmisive_base_tx = emmisive.texture
onready var effect_base_tx = effect.texture
onready var emmiter_base_tx = emmiter.texture

func get_interaction_area():
	return $Light/InteractionArea

func toggle():
	if emmisive.texture != on_toggle_emmisive_texture:
		emmisive.texture = on_toggle_emmisive_texture
	elif emmisive.texture != emmisive_base_tx:
		emmisive.texture = emmisive_base_tx
	
	if effect.texture != on_toggle_effect_texture:
		effect.texture = on_toggle_effect_texture
	elif effect.texture != effect_base_tx:
		effect.texture = effect_base_tx
	
	if emmiter.texture != on_toggle_emmiter_texture:
		emmiter.texture = on_toggle_emmiter_texture
	elif emmiter.texture != emmiter_base_tx:
		emmiter.texture = emmiter_base_tx
	