extends Button

export var scene_to_load : String

onready var character_selection = get_parent().get_parent().get_parent().get_parent().get_node("CharacterSelection")
onready var load_game 			= get_parent().get_parent().get_parent().get_parent().get_node("LoadGame")
onready var options 			= get_parent().get_parent().get_parent().get_parent().get_node("Options")
onready var main_menu 			= get_parent().get_parent().get_parent()

onready var c_s_r_b 			= get_parent().get_parent().get_parent().get_parent().get_node("CharacterSelection/CenterContainer/VBoxContainer/VBoxContainer/BackButton")
onready var l_g_r_b 			= get_parent().get_parent().get_parent().get_parent().get_node("LoadGame/CenterContainer/VBoxContainer/BackButton")
onready var o_r_b 				= get_parent().get_parent().get_parent().get_parent().get_node("Options/CenterContainer/VBoxContainer/BackButton")

# Quits the game.
func _on_QuitGameButton_pressed():
	get_tree().quit()

# Set the label for a menu button.
func set_label(replace_text = $MenuButton.text):
	self.text = replace_text

# Set the scene to be changed to.
func set_scene_to_load(scl):
	self.scene_to_load = scl

# Swap the visible menu nodes.
func set_menu_nodes(control : Control, index_button : Button):
	control.visible   = true
	main_menu.visible = false
	index_button.grab_focus()

func _on_LevelButton_pressed():
	$Audio/Click.play()

func _on_ReturnToGameButton_focus_exited():
	$Audio/Move.play()

func _on_ReturnToMainMenuButton_focus_exited():
	$Audio/Move.play()

func _on_NewGameButton_focus_exited():
	$Audio/Move.play()

func _on_LoadGameButton_focus_exited():
	$Audio/Move.play()

func _on_OptionsButton_focus_exited():
	$Audio/Move.play()

func _on_QuitGameButton_focus_exited():
	$Audio/Move.play()

func _on_LevelButton_focus_exited():
	$Audio/Move.play()

func _on_ReturnButton_exited():
	$Audio/Move.play()

func _on_ReturnButton_focus_exited():
	pass

# Determine the menu logic once a button is pressed.
func _on_MainMenuButton_pressed():
	$Audio/Click.play()
	match(self.name):
		"NewGameButton":
			set_menu_nodes(character_selection, c_s_r_b)
		"LoadGameButton":
			set_menu_nodes(load_game, l_g_r_b)
		"OptionsButton":
			set_menu_nodes(options, o_r_b)
