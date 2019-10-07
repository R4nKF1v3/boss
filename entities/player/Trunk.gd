extends Node2D

onready var camera_pointer = owner.get_node("CameraPointer")

func _physics_process(delta):
	look_at(camera_pointer.global_position)