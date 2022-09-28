extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var index_button = self
	index_button.grab_focus()

# When gets pressed.
func _on_BackButton_pressed():
	get_tree().change_scene("res://scenes/Menu/MainMenu.tscn")
