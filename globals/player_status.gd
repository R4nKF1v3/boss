extends Node

var HP: float
var Insanity: float
var MAX_VALUES : float = 1000

var player

signal player_hp_changed(value)
signal player_insanity_changed(value)

func _ready():
	HP = MAX_VALUES
	Insanity = MAX_VALUES

func take_damage(amount, type):
	match type:
		"hp":
			HP = max(HP - amount, 0)
			emit_signal("player_hp_changed", HP)
			if HP == 0:
				signals.emit_signal("player_dead")
		"insanity":
			Insanity = max(Insanity - amount, 0)
			emit_signal("player_insanity_changed", Insanity)
			if Insanity == 0:
				signals.emit_signal("player_dead")

func heal(amount, type):
	match type:
		"hp":
			emit_signal("player_hp_changed", HP)
			HP = min(HP + amount, MAX_VALUES)
		"insanity":
			emit_signal("player_insanity_changed", Insanity)
			Insanity = min(Insanity + amount, MAX_VALUES)

func get_global_position() -> Vector2:
	return player.global_position