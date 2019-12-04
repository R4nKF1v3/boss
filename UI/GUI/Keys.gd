extends Control

func _ready():
	WorldEvents.connect("show_shift", self, "on_show_shift")
	$Tween.interpolate_property($WASD, "modulate", Color(0, 0, 0, 0), Color(1, 1, 1, 1), 6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($LeftClick, "modulate", Color(0, 0, 0, 0), Color(1, 1, 1, 1), 6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	$Timer.start(8)
	yield($Timer,"timeout")
	$Tween.interpolate_property($WASD, "modulate", Color(1, 1, 1, 1), Color(0, 0, 0, 0), 6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($LeftClick, "modulate", Color(1, 1, 1, 1), Color(0, 0, 0, 0), 6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func on_show_shift():
	$Tween.interpolate_property($Shift, "modulate", Color(0, 0, 0, 0), Color(1, 1, 1, 1), 6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	$Timer.start(8)
	yield($Timer,"timeout")
	$Tween.interpolate_property($Shift, "modulate", Color(1, 1, 1, 1), Color(0, 0, 0, 0), 6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()