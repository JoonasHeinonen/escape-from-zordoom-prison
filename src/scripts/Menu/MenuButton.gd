extends Button

export (String) var scene_to_load

func _ready():
	var index_button = self
	index_button.grab_focus()

# Quits the game.
func _on_QuitGameButton_pressed():
	get_tree().quit()

# Set the label for a menu button.
func set_label(replace_text = $MenuButton.text):
	self.text = replace_text
