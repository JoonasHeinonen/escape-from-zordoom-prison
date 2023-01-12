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

func _on_NewGameButton_pressed():
	$Audio/Click.play()

func _on_LoadGameButton_pressed():
	$Audio/Click.play()

func _on_OptionsButton_pressed():
	$Audio/Click.play()

func _on_LevelButton_pressed():
	$Audio/Click.play()

func _on_ReturnButton_pressed():
	$Audio/Click.play()

func _on_ReturnToGameButton_focus_exited():
	$Audio/Move.play()

func _on_ReturnToMainMenuButton_focus_exited():
	$Audio/Move.play()

func _on_NewGameButton_focus_exited():
	$Audio/Move.play()

func _on_LoadGameButton_focus_exited():
	$Audio/Move.play()

func _on_OptionsButton_focus_exited():
	$Audio/Move.play()

func _on_QuitGameButton_focus_exited():
	$Audio/Move.play()

func _on_LevelButton_focus_exited():
	$Audio/Move.play()

func _on_ReturnButton_exited():
	$Audio/Move.play()

func _on_ReturnButton_focus_exited():
	pass
