extends ColorRect

onready var tween = $Tween

var base = Color("00ffffff")
var target = Color("604a1c9b")

func _ready():
	PlayerStatus.connect("took_insanity_damage", self, "on_damage")

func start_blood_cycle():
	tween.interpolate_property(self, "color", base, target, 0.03, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.start()
	yield(tween,"tween_all_completed")
	tween.interpolate_property(self, "color", target, base, 3, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	tween.start()

func on_damage(value):
	if tween.is_active():
		tween.reset_all()
	else:
		start_blood_cycle()