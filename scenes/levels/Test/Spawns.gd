extends Node2D

func _ready():
	$EnemyShadow.navigation2D = owner.get_node("Navigation2D")
