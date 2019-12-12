extends ColorRect

onready var tween = $Tween

var base = Color("00000000")
var target = Color("000000")

func _ready():
	signals.connect("player_dead", self, "on_player_dead")
	signals.connect("game_over", self, "on_game_over")

func on_player_dead():
	tween.interpolate_property(self, "color", target, base, 6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func on_game_over():
	tween.interpolate_property(self, "color", base, target, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()