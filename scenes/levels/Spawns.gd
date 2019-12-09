extends Node2D

func _ready():
	var nav = owner.get_node("VisibleLayer/Pathtiles")
	var children = get_children()
	for child in children:
		children += child.get_children()
		if child is NPC:
			child.navigation = nav
