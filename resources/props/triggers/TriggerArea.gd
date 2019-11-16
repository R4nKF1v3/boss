extends Node2D
class_name TriggerArea

export (bool) var delete_on_interaction = false

var was_emmited = false

func _ready():
	$Area.connect("body_entered", self, "on_body_entered")

func on_body_entered(body):
	if body is Player:
		print("Player triggered")
		
		var children = get_children()
		for child in children:
			if child is Event:
				child.handle()
	
		if delete_on_interaction:
			self.queue_free()
		was_emmited = true