extends Control

onready var level_button  = preload("res://scenes/Menu/Materials/LevelButton.tscn")
onready var back_button   = $CenterContainer/VBoxContainer/BackButton
onready var angela_sprite = get_parent().get_node("Angela/AngelaSprite")
onready var rivet_sprite  = get_parent().get_node("Rivet/RivetSprite")

var scene 				  = null
var levels 				  = []
var unwanted_chars 		  = ["_",".tscn"]

# Called when the node enters the scene tree for the first time.
func _ready():
	levels = list_levels("res://scenes/Levels")

	# Determine the sprites of the characters.
	if (Globle.player_character == "Rivet"):
		rivet_sprite.frame  = 27
		angela_sprite.frame = 9
	elif (Globle.player_character == "Angela"):
		rivet_sprite.frame  = 9
		angela_sprite.frame = 25

	# Iterates through the levels.
	for level_name in levels:
		var level = level_button.instance()
		level.set_scene_to_load("res://scenes/Levels/" + level_name)
		
		# Takes the chars from the level_name.
		for c in unwanted_chars:
			level_name = level_name.replace(c, " ")
		level_name.erase(level_name.length() - 1, 1)
		level_name = level_name.capitalize()

		level.set_label(level_name)
		level.connect("pressed", self, "_on_Button_pressed", [level.scene_to_load])
		$CenterContainer/VBoxContainer/CenterRow/Buttons/LevelList.add_child(level)
	back_button.grab_focus()

# Loads the scene defined to a particular button.
func _on_Button_pressed(scene_to_load):
	scene = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()

# Run when FadeIn fade is finished.
func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene)

# Lists all the levels.
func list_levels(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif file.ends_with(".tscn"):
			files.append(file)

	dir.list_dir_end()

	return files
