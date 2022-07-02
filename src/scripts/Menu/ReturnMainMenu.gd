extends Control

# Returns to the main menu.
func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Menu/MainMenu.tscn")
