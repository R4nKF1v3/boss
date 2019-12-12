extends Node2D

func _ready():
	var nav = owner.get_node("VisibleLayer/Pathtiles")
	var children = get_children()
	while children.size() > 0:
		var child = children.pop_front()
		if child is VisibleEnemy:
			child.navigation = nav
		children += child.get_children()
		
