extends AudioStreamPlayer

onready var timer = $Timer
onready var tween = $Tween

func _ready():
	PlayerStatus.connect("took_insanity_damage", self, "on_insanity_damage")
	PlayerStatus.connect("took_hp_damage", self, "on_hp_damage")
	timer.connect("timeout", self, "on_timer_timeout")
	tween.connect("tween_all_completed", self, "on_tween_completed")

func on_hp_damage(value):
	on_damage(-20)

func on_insanity_damage(value):
	on_damage(-30)

func on_damage(db):
	if !playing:
		play()
	if tween.is_active():
		tween.remove_all()
	volume_db = db
	timer.start(2)
	
func on_timer_timeout():
	tween.interpolate_property(self, "volume_db", null, -60, 4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func on_tween_completed():
	stop()