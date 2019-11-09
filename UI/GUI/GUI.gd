extends Control

func _ready():
	signals.connect("player_dead", self, "on_player_dead")

func on_player_dead():
	$Ded.text = "Ur ded"
	$Ded.show()
