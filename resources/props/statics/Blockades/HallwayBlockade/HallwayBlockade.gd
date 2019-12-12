extends "res://resources/props/statics/StaticProp.gd"

onready var inner_prop = $StaticProp/StaticBody2D
onready var occluder = $StaticProp/LightOccluder2D

var inner_prop_coll = []
var occluder_coll

func _ready():
	inner_prop_coll = [inner_prop.collision_layer, inner_prop.collision_mask]
	occluder_coll = occluder.occluder

func toggle():
	if on_toggle_collision_switch && inner_prop.collision_layer == inner_prop_coll[0] && inner_prop.collision_mask == inner_prop_coll[1]:
		inner_prop.collision_layer = 262144
		inner_prop.collision_mask = 262144
	elif inner_prop.collision_layer != inner_prop_coll[0] && inner_prop.collision_mask != inner_prop_coll[1]:
		inner_prop.collision_layer = inner_prop_coll[0]
		inner_prop.collision_mask = inner_prop_coll[1]
	
	if occluder.occluder == occluder_coll:
		occluder.occluder = OccluderPolygon2D.new()
	elif occluder.occluder != occluder_coll:
		occluder.occluder = occluder_coll
	.toggle()
	