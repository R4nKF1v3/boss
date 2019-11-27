extends Node2D

export (bool) var with_timer = false
export (float) var duration = 0
export (float) var melee_damage = 3
export (float) var insanity_damage = 3
export (float) var detection_range = 800
export (float) var FOV = 90

onready var enemy_template = preload("res://entities/npcs/enemies/shadow/EnemyShadow.tscn")

var spawned

func handle_world_event(eventType, event):
	match eventType:
		WorldEvents.event_types.Trigger:
			if event.wait_time > 0:
				var timer = Timer.new()
				timer.name = "TriggerTimer"
				add_child(timer)
				timer.start(event.wait_time)
				yield(timer, "timeout")
				remove_child(timer)
				timer.queue_free()
			trigger_spawn()

func trigger_spawn():
	if spawned:
		remove_child(spawned)
		spawned.queue_free()
		spawned = null
		if with_timer:
			var timer = get_child(0)
			remove_child(timer)
			timer.queue_free()
	else:
		var enemy = enemy_template.instance()
		enemy.navigation = get_pathtiles()
		enemy.INSANITY_DAMAGE = insanity_damage
		enemy.MELEE_DAMAGE = melee_damage
		enemy.DETECTION_RANGE = detection_range
		enemy.FOV = FOV
		add_child(enemy)
		spawned = enemy
		if with_timer:
			var timer = Timer.new()
			timer.connect("timeout", self, "on_timer_timeout")
			add_child(timer)
			timer.start(duration)

func on_timer_timeout():
	remove_child(spawned)
	spawned.queue_free()
	spawned = null
	var timer = get_child(0)
	remove_child(timer)
	timer.queue_free()

func get_pathtiles():
	return owner.get_node("VisibleLayer/Pathtiles")


