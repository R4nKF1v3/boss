extends Node

func _ready():
	$CanvasLayer/Foreground/HBoxContainer/VBoxContainer/VBoxContainer/Play.connect("pressed", self, "on_play_pressed")
	$CanvasLayer/Foreground/HBoxContainer/VBoxContainer/VBoxContainer/Exit.connect("pressed", self, "on_exit_pressed")

func on_play_pressed():
	get_tree().change_scene("res://scenes/loading/LoadingScreen.tscn")

func on_exit_pressed():
	get_tree().quit()
