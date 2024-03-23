extends MenuSceneControlBase

@onready var level_button = preload("res://scenes/Menu/Materials/LevelButton.tscn")
@onready var back_button = $CenterContainer/VBoxContainer/BackButton
@onready var angela_sprite = get_parent().get_node("Angela/AngelaSprite")
@onready var rivet_sprite = get_parent().get_node("Rivet/RivetSprite")

var scene = null
var levels = []
var unwanted_chars = ["_",".tscn"]

func _ready():
	levels = list_levels("res://scenes/Levels")

	if (Globle.player_character == "Rivet"):
		rivet_sprite.frame = 27
		angela_sprite.frame = 9
	elif (Globle.player_character == "Angela"):
		rivet_sprite.frame = 9
		angela_sprite.frame = 25

	for level_name in levels:
		var level = level_button.instantiate()
		level.set_scene_to_load("res://scenes/Levels/" + level_name)
		
		# Takes the chars from the level_name.
		for c in unwanted_chars:
			level_name = level_name.replace(c, " ")
		level_name.erase(level_name.length() - 1, 1)
		level_name = level_name.capitalize()

		level.set_label(level_name)
		level.connect("pressed", Callable(self, "_on_Button_pressed").bind(level.scene_to_load))
		$CenterContainer/VBoxContainer/CenterRow/Buttons/LevelList.add_child(level)
	back_button.grab_focus()

func _process(delta):
	if (Globle.game_fullscreen):
		$CenterContainer.size = Vector2(1920, 1080)
	elif (!Globle.game_fullscreen):
		$CenterContainer.size = Vector2(1280, 720)

func list_levels(path):
	var files = []
	var dir = DirAccess.open(path)
	dir.list_dir_begin() # TODOConverter3To4 fill missing arguments https://github.com/godotengine/godot/pull/40547

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif file.ends_with(".tscn"):
			files.append(file)
	dir.list_dir_end()

	return files

func _on_Button_pressed(scene_to_load):
	scene = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_FadeIn_fade_finished():
	get_tree().change_scene_to_file(scene)
