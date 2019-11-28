extends TextureRect

onready var hp = PlayerStatus.HP
onready var base = modulate

func _ready():
	PlayerStatus.connect("player_hp_changed", self, "on_hp_changed")
	print(modulate)

func _process(delta):
	var modcopy = base
	modcopy.a = hp
	var val = modcopy if modulate != modcopy else base
	modulate = lerp(modulate, val, 0.05)

func on_hp_changed(value):
	hp = value