extends CheckBox

func _process(_delta):
	if !Globle.game_fullscreen:
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (false) else Window.MODE_WINDOWED
		self.button_pressed = false
	else:
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (true) else Window.MODE_WINDOWED
		self.button_pressed = true

func _on_ScreenCheckBox_pressed():
	self.grab_focus()
	Globle.game_fullscreen = !Globle.game_fullscreen
