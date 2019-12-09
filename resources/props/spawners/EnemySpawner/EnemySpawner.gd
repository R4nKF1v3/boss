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
		call_deferred("remove_child", spawned)
		if with_timer:
			var timer = get_child(0)
			call_deferred("remove_child", timer)
	else:
		var entity = enemy_template.instance()
		entity.navigation = get_pathtiles()
		entity.INSANITY_DAMAGE = insanity_damage
		entity.MELEE_DAMAGE = melee_damage
		entity.DETECTION_RANGE = detection_range
		entity.FOV = FOV
		call_deferred("add_child", entity)
		spawned = entity
		if with_timer:
			var timer = Timer.new()
			timer.connect("timeout", self, "on_timer_timeout")
			call_deferred("add_child",timer)
			timer.call_deferred("start",duration)

func on_timer_timeout():
	call_deferred("remove_child", spawned)
	var timer = get_child(0)
	call_deferred("remove_child",timer)

func get_pathtiles():
	return owner.get_node("VisibleLayer/Pathtiles")

func remove_child(node):
	.remove_child(node)
	node.call_deferred("queue_free")
	spawned = null
