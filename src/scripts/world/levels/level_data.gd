extends Node

class_name LevelData

## Dynamic weather data variables
@export var weather_rain : bool = false
@export var weather_storm : bool = false
@export var weather_cloudy : bool = false
@export var weather_fog : bool = false

@export var z_axis : float
@export var default_music_stream : AudioStreamMP3

var default_music = AudioStreamPlayer.new()

var player = null

func _ready():
	default_music_stream.loop = true
	default_music.set_stream(default_music_stream)

	add_child(default_music)
	player = get_node("player")
	set_music(default_music, default_music_stream)

	if (get_node("npc/friendly")):
		for npc in $npc/friendly.get_children():
			npc.position.z = z_axis
			print(npc.position.z)
	else:
		printerr("Does not exist...")

func set_music(
		music : AudioStreamPlayer,
		music_stream : AudioStreamMP3
	):
	music.set_autoplay(true)
	music.play()
