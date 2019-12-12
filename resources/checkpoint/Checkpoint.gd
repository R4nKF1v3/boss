extends Node2D

export (bool) var is_last = false

var used = false

func _ready():
	$Area2D.connect("body_entered", self, "on_body_entered")

func on_body_entered(body):
	if !used && body is Player:
		mark_as_new_checkpoint()

func mark_as_new_checkpoint():
	PlayerStatus.checkpoint = self
	used = true
	print("marked checkpoint")
	print(global_position)