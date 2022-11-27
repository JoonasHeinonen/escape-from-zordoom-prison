extends Button

export (String) var scene_to_load

# Quits the game.
func _on_QuitGameButton_pressed():
	get_tree().quit()

# Set the label for a menu button.
func set_label(replace_text = $MenuButton.text):
	self.text = replace_text

# Set the scene to be changed to.
func set_scene_to_load(scl):
	self.scene_to_load = scl
