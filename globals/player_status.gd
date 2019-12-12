extends Node

var HP: float
var Insanity: float
var MAX_VALUES : float = 1000

var player : Player

var checkpoint
var is_dead = false

signal took_hp_damage(value)
signal took_insanity_damage(value)

func _ready():
	HP = MAX_VALUES
	Insanity = MAX_VALUES

func take_damage(amount, type):
	if is_dead:
		return
	match type:
		"hp":
			HP = max(HP - amount, 0)
			emit_signal("took_hp_damage", HP)
			if HP == 0:
				process_death()
		"insanity":
			Insanity = max(Insanity - amount, 0)
			emit_signal("took_insanity_damage", Insanity)
			if Insanity == 0:
				process_death()

func heal(amount, type):
	match type:
		"hp":
			HP = min(HP + amount, MAX_VALUES)
		"insanity":
			Insanity = min(Insanity + amount, MAX_VALUES)

func get_global_position() -> Vector2:
	return player.global_position

func process_death():
	is_dead = true
	if !checkpoint.is_last:
		signals.emit_signal("player_dead")
		player.teleport_to = checkpoint.global_position
		yield(get_tree().create_timer(2.0), "timeout")
		is_dead = false
		HP = MAX_VALUES / 2
		Insanity = MAX_VALUES
		emit_signal("took_hp_damage", HP)
		emit_signal("took_insanity_damage", Insanity)
	else:
		signals.emit_signal("game_over")