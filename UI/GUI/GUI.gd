extends Control

func _ready():
	signals.connect("player_dead", self, "on_player_dead")

func _process(delta):
	var fps = String(Performance.get_monitor(Performance.TIME_FPS))
	$FPS.text = "FPS: " + fps

func on_player_dead():
	$Ded.text = "Ur ded"
	$Ded.show()
