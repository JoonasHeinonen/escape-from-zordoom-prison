extends MenuSceneControlBase


var index_btn
var sec_index_btn
var btn_to_return_to

@export_enum("StartGame", "LoadGame", "Options") var menus: String

func _on_BackButton_pressed():
	$Audio/Click.play()
	if (self.has_node('CenterContainer')):
		index_btn = $CenterContainer/VBoxContainer/BackButton
		sec_index_btn = $CenterContainer/VBoxContainer/VBoxContainer/BackButton

	match(get_tree().get_current_scene().get_name()):
		"MainMenu":
			self.visible = false
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
			get_tree().change_scene_to_file("res://scenes/Menu/MainMenu.tscn")

func _on_BackButton_focus_exited():
	$Audio/Move.play()

func _on_BackButtonCS_focus_exited():
	$Audio/Move.play()
