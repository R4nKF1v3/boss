extends ColorRect

onready var tween = $Tween

var base = Color("00ffffff")
var target = Color("3affffff")

func _ready():
	PlayerStatus.connect("took_insanity_damage", self, "on_damage")

func start_blood_cycle():
	tween.interpolate_property(self, "color", target, base, 5, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	tween.start()

func on_damage(value):
	if tween.is_active():
		tween.reset_all()
	else:
		start_blood_cycle()