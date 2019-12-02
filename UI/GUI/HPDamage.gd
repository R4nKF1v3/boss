extends Container

onready var tween = $Tween
onready var blood = $Blood
onready var flash = $Flash

var base = Color("00ffffff")
var target = Color("ffffff")

func _ready():
	PlayerStatus.connect("took_hp_damage", self, "on_damage")

func start_blood_cycle():
	var flashmod = Color("00490d0d")
	var flashtar = Color("b7490d0d")
	tween.interpolate_property(blood, "modulate", base, target, 0.03, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.interpolate_property(flash, "modulate", flashmod, flashtar, 0.03, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.start()
	yield(tween,"tween_all_completed")
	tween.interpolate_property(blood, "modulate", target, base, 5, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	tween.interpolate_property(flash, "modulate", flashtar, flashmod, 0.03, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func on_damage():
	start_blood_cycle()
