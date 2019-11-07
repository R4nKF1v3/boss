extends InteractuableEvent

func get_interaction_area() -> Area2D:
	return $Door/Doorway/InteractionArea as Area2D
