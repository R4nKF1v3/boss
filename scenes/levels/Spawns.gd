extends Node2D

func _ready():
	var nav = owner.get_node("VisibleLayer/Pathtiles")
	var children = get_children()
	for child in children:
		if child is NPC:
			child.navigation = nav

func add_child(node, legible_unique_name=false):
	print(node)
	.add_child(node, legible_unique_name)