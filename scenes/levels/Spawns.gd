extends Node2D

func _ready():
	var nav = owner.get_node("Pathtiles")
	var children = get_children()
	for child in children:
		if child is NPC:
			child.navigation = nav