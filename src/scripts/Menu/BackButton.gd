extends Button

func _on_BackButton_focus_exited():
	$Audio/Move.play()
