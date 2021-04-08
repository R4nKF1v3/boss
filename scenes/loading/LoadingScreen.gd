extends Control

var thread = null

onready var progress = $TextureProgress
onready var percentage = $Perc

func _ready():
	thread = Thread.new()
	thread.start( self, "_thread_load", "res://scenes/main/Main.tscn")
	raise() # show on top
	progress.visible = true

func _thread_load(path):
	var ril = ResourceLoader.load_interactive(path)
	assert(ril)
	var total = ril.get_stage_count()
	# Call deferred to configure max load steps
	progress.call_deferred("set_max", total)
	
	var res = null
	
	while true: #iterate until we have a resource
		# Update progress bar, use call deferred, which routes to main thread
		call_deferred("update_progress", ril.get_stage())
		# Poll (does a load step)
		var err = ril.poll()
		# if OK, then load another one. If EOF, it' s done. Otherwise there was an error.
		if err == ERR_FILE_EOF:
			# Loading done, fetch resource
			res = ril.get_resource()
			break
		elif err != OK:
			# Not OK, there was an error
			print("There was an error loading")
			break
	
	# Send whathever we did (or not) get
	call_deferred("_thread_done", res)

func _thread_done(resource):
	assert(resource)
	
	# Always wait for threads to finish, this is required on Windows
	thread.wait_to_finish()
	
	# Instantiate new scene
	var new_scene = resource.instance()
	# Free current scene
	get_tree().current_scene.queue_free()
	get_tree().current_scene = null
	# Add new one to root
	get_tree().root.add_child(new_scene)
	# Set as current scene
	get_tree().current_scene = new_scene
	

func update_progress(value):
	progress.value = value
	percentage.text = str(stepify(((value * 100) / progress.max_value),1))+"%"
