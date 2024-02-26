extends Node

class_name LevelData

var z_axis = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if (get_node("npc/friendly")):
		for npc in $npc/friendly.get_children():
			npc.position.z = -1.25
			print(npc.position.z)
	else:
		printerr("Does not exist...")
