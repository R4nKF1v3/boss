extends Node

onready var main = $Main
onready var background = $Background
onready var tween = $Tween

signal completed

var turn = 0
var curr_turn = 0

func handle(event : AmbienceAudioEvent):
	turn += 1
	var my_turn = turn
	if tween.is_active():
		while my_turn != curr_turn:
			yield(self, "completed")
	match event.type:
		"Replace Main":
			var new_player = AudioStreamPlayer.new()
			new_player.stream = event.sound
			new_player.volume_db = -30
			new_player.bus = event.bus
			if main.get_child_count() > 0:
				var old_player = main.get_child(0)
				main.add_child(new_player)
				new_player.play()
				tween.interpolate_property(old_player, "volume_db", old_player.volume_db, -30, 3,Tween.TRANS_LINEAR, Tween.EASE_OUT)
				tween.interpolate_property(new_player, "volume_db", new_player.volume_db, event.db_level, 3,Tween.TRANS_LINEAR, Tween.EASE_IN)
				tween.start()
				yield(tween, "tween_all_completed")
				tween.remove_all()
				main.remove_child(old_player)
				old_player.queue_free()
			else:
				main.add_child(new_player)
				new_player.play()
				tween.interpolate_property(new_player, "volume_db", new_player.volume_db, event.db_level, 3,Tween.TRANS_LINEAR, Tween.EASE_IN)
				tween.start()
				yield(tween, "tween_all_completed")
				tween.remove_all()
			
		"Add to Background":
			var new_player = AudioStreamPlayer.new()
			new_player.stream = event.sound
			new_player.volume_db = -30
			new_player.bus = event.bus
			new_player.connect("finished", self, "on_stream_player_finished")
			background.add_child(new_player)
			new_player.play()
			tween.interpolate_property(new_player, "volume_db", new_player.volume_db, event.db_level, 0.5,Tween.TRANS_LINEAR, Tween.EASE_IN)
			tween.start()
			yield(tween, "tween_all_completed")
			print(new_player.volume_db)
			tween.remove_all()
		"Remove Audio":
			seek_and_delete(main, event.sound)
			seek_and_delete(background, event.sound)
	
	curr_turn = my_turn + 1
	emit_signal("completed")


func seek_and_delete(element, sound):
	for player in element.get_children():
		var stream = player.stream
		if player.stream == sound:
			tween.interpolate_property(player, "volume_db", player.volume_db, -30, 0.5,Tween.TRANS_LINEAR, Tween.EASE_OUT)
			tween.start()
			yield(tween, "tween_all_completed")
			tween.remove_all()
			element.remove_child(player)
			player.queue_free()

func on_stream_player_finished():
	clean_finished_players(main)
	clean_finished_players(background)

func clean_finished_players(node):
	for player in node.get_children():
		if !player.playing:
			node.remove_child(player)
			player.queue_free()




