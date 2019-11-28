extends Sprite

export (Color) var target_color = Color("00ffffff")

onready var initial_color = modulate
onready var tween = $Tween

func handle_world_event(eventType, event):
	match eventType:
		WorldEvents.event_types.Trigger:
			if event.wait_time > 0:
				var timer = Timer.new()
				timer.name = "TriggerTimer"
				add_child(timer)
				timer.start(event.wait_time)
				yield(timer, "timeout")
				remove_child(timer)
				timer.queue_free()
			trigger_modulate()

func trigger_modulate():
	var target = target_color if modulate == initial_color else initial_color
	tween.interpolate_property(self, "modulate", modulate, target, 3, Tween.TRANS_CUBIC,Tween.EASE_OUT)
	tween.start()
	