class_name PlayerHit_box

extends Area

export var damage 		:=10
#https://www.youtube.com/watch?v=JWjzSn95bM0
#13:00
#use the stuff from the npc to enter the hurt box
var _velocity := Vector3.AXIS_X
func _init() -> void:
	collision_layer=2
	collision_mask=0
