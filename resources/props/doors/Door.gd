extends InteractuableElement

func get_interaction_area():
	return $Door/Doorway/InteractionArea

func get_global_position() -> Vector2:
	return $Door/Doorway.global_position