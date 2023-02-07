extends Control

onready var index_btn     = $CenterContainer/VBoxContainer/BackButton
onready var sec_index_btn = $CenterContainer/VBoxContainer/VBoxContainer/BackButton

export (String, "StartGame", "LoadGame", "Options") var menus

# Called when the node enters the scene tree for the first time.
func _ready():
	index_btn.grab_focus() if index_btn != null else self.grab_focus()
	sec_index_btn.grab_focus() if sec_index_btn != null else self.grab_focus()
	$Audio/Click.play()

# When gets pressed.
func _on_BackButton_pressed():
	match menus:
		"LoadGame":
			Globle.menu_to_return = "LoadGame"
		"Options":
			Globle.menu_to_return = "Options"
		"StartGame":
			Globle.menu_to_return = "StartGame"
		_:
			Globle.menu_to_return = "StartGame"
	get_tree().change_scene("res://scenes/Menu/MainMenu.tscn")

func _on_BackButton_focus_exited():
	$Audio/Move.play()
