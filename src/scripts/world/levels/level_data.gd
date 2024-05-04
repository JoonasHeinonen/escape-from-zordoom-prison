extends Node

class_name LevelData

@export var z_axis : float
# AudioStreamPlayer3D
@export var music_stream : AudioStreamMP3

var music = AudioStreamPlayer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(music)

	if (music_stream):
		music.set_stream(music_stream)
		music.play()
	else:
		printerr("No musical track was provided for this level.")

	if (get_node("npc/friendly")):
		for npc in $npc/friendly.get_children():
			npc.position.z = z_axis
			print(npc.position.z)
	else:
		printerr("Does not exist...")
