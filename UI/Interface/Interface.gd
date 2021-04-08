extends Control

onready var label = $Container/Inside/Label
onready var button1 = $Container/Inside/Button
onready var button2 = $Container/Inside/Button2

func _ready():
	signals.connect("game_over", self, "on_game_over")
	button1.connect("pressed", self, "on_button1_pressed")
	button2.connect("pressed", self, "on_button2_pressed")
	hide()

func _unhandled_input(event):
	if event.is_action_pressed("menu") && !visible:
		get_tree().paused = true
		show()
	elif event.is_action_pressed("menu") && visible:
		get_tree().paused = false
		hide()

func on_game_over():
	show()
	label.text = "Gracias por Jugar!"
	button1.hide()

func on_button1_pressed():
	get_tree().paused = false
	hide()

func on_button2_pressed():
	get_tree().quit()
