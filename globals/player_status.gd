extends Node

var HP: float
var Insanity: float
var MAX_VALUES : float = 1000

var player

func _ready():
	HP = MAX_VALUES
	Insanity = MAX_VALUES

func take_damage(amount, type):
	match type:
		"hp":
			HP = max(HP - amount, 0)
			if HP == 0:
				signals.emit_signal("player_dead")
		"insanity":
			Insanity = max(Insanity - amount, 0)
			if Insanity == 0:
				signals.emit_signal("player_dead")

func heal(amount, type):
	match type:
		"hp":
			HP = min(HP + amount, MAX_VALUES)
		"insanity":
			Insanity = min(Insanity + amount, MAX_VALUES)

func get_global_position() -> Vector2:
	return player.global_position