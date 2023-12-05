extends Control

func _ready():
	$CancelContainer/CancelButton.grab_focus()
	
func _on_CancelButton_pressed():
	var main_menu = load("res://src/scripts/Menu/MainMenu.gd")
	main_menu.button_focus()
	get_tree().current_scene.remove_child(self)
