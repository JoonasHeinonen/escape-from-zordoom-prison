extends Node

class_name LevelData

@export var z_axis : float
@export var default_music_stream : AudioStreamMP3
## TODO Specify proper data types for key and value: <String><bool>
@export var mission_params : Dictionary = {}

var is_level_complete : bool = false
var default_music = AudioStreamPlayer.new()

var player = null

func _ready():
	if default_music_stream:
		default_music_stream.loop = true
	default_music.set_stream(default_music_stream)

	## HINT Use the following pattern to add new mission parameters.
	## mission_params.merge({ "newMission": false })

	add_child(default_music)
	player = get_node("player")
	set_music(default_music, default_music_stream)

	if (get_node("npc/friendly")):
		for npc in $npc/friendly.get_children():
			npc.position.z = z_axis

func _process(_delta):
	var mission_param_index : int = 0
	var finished_missions : int = 0

	for mission_param in mission_params:
		var mission_finished : bool = mission_params.values()[mission_param_index]
		if (mission_finished):
			finished_missions = finished_missions + 1
	if (mission_params.size() == finished_missions):
		is_level_complete = true
	if (is_level_complete):
		print("All level parameters are complete")

func set_music(
		music : AudioStreamPlayer,
		music_stream : AudioStreamMP3
	):
	music.set_autoplay(true)
	music.play()
