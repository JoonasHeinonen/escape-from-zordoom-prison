extends "res://src/scripts/Menu/MenuButton.gd"

@export_enum("Angela", "Rivet") var characters: String
var res_string: String = ""

func _ready():
	res_string = "res://resources/images/characters/player/%s/%s_character_selection.png"
	$CharacterImage.texture = load(res_string % [characters.to_lower(), characters.to_lower()])
	$CharacterPanel/CharacterName.text = characters

func _on_CharacterSelectionButton_pressed():
	Globle.player_character = characters
	get_tree().change_scene_to_file(scene_to_load)

func _on_CharacterSelectionButton_focus_exited():
	$Audio/Move.play()
