extends HBoxContainer

func _ready():
	$LifeBar.max_value = PlayerStatus.MAX_VALUES
	$InsanityBar.max_value = PlayerStatus.MAX_VALUES

func _process(delta):
	$LifeBar.value = PlayerStatus.HP
	$InsanityBar.value = abs(PlayerStatus.Insanity - PlayerStatus.MAX_VALUES)
