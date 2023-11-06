extends Control

onready var main_menu = get_parent().get_node("MainMenu")

var index_btn
var sec_index_btn
var btn_to_return_to

export (String, "StartGame", "LoadGame", "Options") var menus

func _ready():
	if (self.name == "Options"):
		var screen_check_box = $CenterContainer/VBoxContainer/ScreenCheckBox
		if !Globle.game_fullscreen:
			screen_check_box.pressed = false
		else:
			screen_check_box.pressed = true

func _on_BackButton_pressed():
	$Audio/Click.play()
	if (self.has_node('CenterContainer')) : index_btn = $CenterContainer/VBoxContainer/BackButton
	if (self.has_node('CenterContainer')) : sec_index_btn = $CenterContainer/VBoxContainer/VBoxContainer/BackButton

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

func _on_ScreenCheckBox_pressed():
	if (self.name == "Options"):
		Globle.game_fullscreen = !Globle.game_fullscreen
