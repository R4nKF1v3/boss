extends Node2D

func _ready():
	var children = get_children()
	for child in children:
		if child.name != "PlayerContainer":
			child.navigation2D = owner.get_node("Navigation2D")