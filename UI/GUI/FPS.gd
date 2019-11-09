tool
extends Label

func _process(delta):
	var fps = String(Performance.get_monitor(Performance.TIME_FPS))
	text = "FPS: " + fps
