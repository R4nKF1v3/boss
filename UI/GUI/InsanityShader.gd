extends ColorRect

func _ready():
	PlayerStatus.connect("took_insanity_damage", self, "on_insanity_damage")

func on_insanity_damage(value):
	var aberration = (abs(value - 1000) * 0.004) / 1000
	var curvature = (abs(value - 1000) * 0.15) / 1000
	material.set_shader_param("abberationAmt", aberration)
	material.set_shader_param("screenCurvature", 1 + curvature)