extends Control

onready var main_menu 			= get_parent().get_node("MainMenu")

onready var index_btn 			= $CenterContainer/VBoxContainer/BackButton
onready var sec_index_btn 		= $CenterContainer/VBoxContainer/VBoxContainer/BackButton

var btn_to_return_to

export (String, "StartGame", "LoadGame", "Options") var menus

# When gets pressed.
func _on_BackButton_pressed():
	$Audio/Click.play()
	match(get_tree().get_current_scene().get_name()):
		"MainMenu":
			self.visible = false
			main_menu.visible = true
			match menus:
				"LoadGame":
					btn_to_return_to = get_parent().get_node("MainMenu/CenterContainer/Buttons/LoadGameButton")
					btn_to_return_to.grab_focus()
				"Options":
					btn_to_return_to = get_parent().get_node("MainMenu/CenterContainer/Buttons/OptionsButton")
					btn_to_return_to.grab_focus()
				"StartGame":
					btn_to_return_to = get_parent().get_node("MainMenu/CenterContainer/Buttons/NewGameButton")
					btn_to_return_to.grab_focus()
				_:
					btn_to_return_to = get_parent().get_node("MainMenu/CenterContainer/Buttons/NewGameButton")
					btn_to_return_to.grab_focus()
		"LevelView":
			get_tree().change_scene("res://scenes/Menu/MainMenu.tscn")

func _on_BackButton_focus_exited():
	$Audio/Move.play()

func _on_BackButtonCS_focus_exited():
	$Audio/Move.play()
