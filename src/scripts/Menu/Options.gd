extends Control

func _ready():
	$CancelContainer/CancelButton.grab_focus()

func _on_CancelButton_pressed():
	get_tree().current_scene.remove_child(self)
