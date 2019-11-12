extends Sprite

var target

func _ready():
	modulate = World_Properties.canvas_default
	WorldEvents.connect("change_canvas_color", self, "_on_change_canvas_color_event")
	set_process(false)

func _process(delta):
	modulate = lerp(modulate, target, 0.01)
	if modulate == target:
		target = null
		set_process(false)

func _on_change_canvas_color_event(newColor):
	target = newColor
	set_process(true)
