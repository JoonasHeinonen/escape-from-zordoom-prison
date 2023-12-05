extends CheckBox

func _process(delta):
	if !Globle.game_fullscreen:
		OS.window_fullscreen = false
		self.pressed = false
	else:
		OS.window_fullscreen = true
		self.pressed = true

func _on_ScreenCheckBox_pressed():
	print("Scripts screenscheck ogfk ")
	self.grab_focus()
	Globle.game_fullscreen = !Globle.game_fullscreen
