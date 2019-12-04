extends TextureRect

onready var tween = $Tween

var base = Color("00ffffff")
var target = Color("caa20c0c")

func _ready():
	PlayerStatus.connect("took_hp_damage", self, "on_damage")

func start_blood_cycle():
	tween.interpolate_property(self, "modulate", base, target, 0.03, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.start()
	yield(tween,"tween_all_completed")
	tween.interpolate_property(self, "modulate", target, base, 0.03, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	tween.start()

func on_damage(value):
	if !tween.is_active():
		start_blood_cycle()