extends Node

class_name LevelData

@export var z_axis : float
@export var default_music_stream : AudioStreamMP3
@export var boss_music_stream : AudioStreamMP3

var default_music = AudioStreamPlayer.new()
var boss_music = AudioStreamPlayer.new()

var player = null

func _ready():
	default_music_stream.loop = true
	boss_music_stream.loop = true
	default_music.set_stream(default_music_stream)
	boss_music.set_stream(boss_music_stream)

	add_child(default_music)
	add_child(boss_music)
	player = get_node("player")
	play_music()

	if (get_node("npc/friendly")):
		for npc in $npc/friendly.get_children():
			npc.position.z = z_axis
			print(npc.position.z)
	else:
		printerr("Does not exist...")

func play_music(boss_fight_on : bool = false):
	if !boss_fight_on:
		set_music(default_music, boss_music, default_music_stream)
	elif boss_fight_on:
		set_music(boss_music, default_music, boss_music_stream)

func set_music(
		music : AudioStreamPlayer,
		music_to_disable : AudioStreamPlayer,
		music_stream : AudioStreamMP3
	):
	music_to_disable.set_autoplay(false)
	music.set_autoplay(true)
	music_to_disable.stop()
	music.play()
