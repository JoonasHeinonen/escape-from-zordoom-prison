extends "res://src/scripts/Menu/MenuButton.gd"

export (String, "Angela", "Rivet") var characters
var res_string: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	res_string = "res://resources/images/characters/player/%s/%s_character_selection.png"
	$CharacterImage.texture = load(res_string % [characters.to_lower(), characters.to_lower()])
	$CharacterPanel/CharacterName.text = characters

# When selecting the player character.
func _on_CharacterSelectionButton_pressed():
	Globle.player_character = characters
	get_tree().change_scene(scene_to_load)
	print(Globle.player_character)
