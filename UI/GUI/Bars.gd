extends HBoxContainer

func _ready():
	$LifeBar.max_value = PlayerStatus.MAX_VALUES
	$LifeBar.value = PlayerStatus.HP
	$InsanityBar.max_value = PlayerStatus.MAX_VALUES
	PlayerStatus.connect("took_hp_damage", self, "on_hp_damage")
	PlayerStatus.connect("took_insanity_damage", self, "on_insanity_damage")

func on_hp_damage(value):
	$LifeBar.value = value

func on_insanity_damage(value):
	$InsanityBar.value = abs(value - PlayerStatus.MAX_VALUES)
