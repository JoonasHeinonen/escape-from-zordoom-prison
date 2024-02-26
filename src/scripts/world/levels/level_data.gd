extends Node

class_name LevelData

@export var z_axis : float

# Called when the node enters the scene tree for the first time.
func _ready():
	if (get_node("npc/friendly")):
		for npc in $npc/friendly.get_children():
			npc.position.z = z_axis
			print(npc.position.z)
	else:
		printerr("Does not exist...")
