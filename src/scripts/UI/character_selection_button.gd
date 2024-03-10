extends "res://src/scripts/Menu/MenuButton.gd"

@export var characters : String
var res_string: String = ""

func _ready():
	# it seems to be missing the chara selection files
	res_string = "res://resources/images/characters/player/%s/%s_character_selection.png"
	#res_string = "res://resources/images/characters/player/"
	#$CharacterImage.texture = load(res_string % [characters.to_lower(), characters.to_lower()])
	print(characters)
	$CharacterImage.texture = load(res_string % [characters.to_lower(), characters.to_lower()])
	$CharacterPanel/CharacterName.text = characters

func _on_CharacterSelectionButton_pressed():
	print(characters)
	Globle.player_character = characters
	get_tree().change_scene_to_file(scene_to_load)

func _on_CharacterSelectionButton_focus_exited():
	$Audio/Move.play()
