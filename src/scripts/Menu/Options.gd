extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$CancelContainer/CancelButton.grab_focus()

# Return to the menu.
func _on_CancelButton_pressed():
	get_tree().current_scene.remove_child(self)
