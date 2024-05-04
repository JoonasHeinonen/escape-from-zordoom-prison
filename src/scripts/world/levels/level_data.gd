extends Node

class_name LevelData

@export var z_axis : float
@export var default_music_stream : AudioStreamMP3
@export var boss_music_stream : AudioStreamMP3

var player = null

var music = AudioStreamPlayer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(music)
	player = get_node("player")

	if (default_music_stream):
		default_music_stream.loop = true
		music.set_stream(default_music_stream)
		music.set_autoplay(true)
		music.play()
	else:
		printerr("No musical track was provided for this level.")

	if (get_node("npc/friendly")):
		for npc in $npc/friendly.get_children():
			npc.position.z = z_axis
			print(npc.position.z)
	else:
		printerr("Does not exist...")
