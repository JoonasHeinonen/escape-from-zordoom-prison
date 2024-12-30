extends MenuSceneControlBase

@onready var return_btn = $VBoxContainer/CenterRow/Buttons/ReturnToGameButton
@onready var screen_check_box = $VBoxContainer/CenterRow/Buttons/ScreenCheckBox
@onready var exit_btn = $VBoxContainer/CenterRow/Buttons/ReturnToMainMenuButton

var btns : Array = [return_btn, exit_btn]

func _process(_delta):
	if (Globle.vendor_active):
		self.hide()
	if (Globle.game_fullscreen):
		self.size = Vector2(1920, 1080)
	elif (!Globle.game_fullscreen):
		self.size = Vector2(1280, 720)
	if (self.visible):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event):
	if event.is_action_pressed("ui_esc") and Dialogic.current_timeline == null:
		if (!Globle.player_inventory):
			return_btn.grab_focus()
			if (!self.visible && !get_tree().paused):
				show()
				get_tree().paused = true
			elif (self.visible):
				_on_ReturnToGameButton_pressed()
	if event.is_action_pressed("ui_accept"):
		if (return_btn.has_focus()):
			_on_ReturnToGameButton_pressed()
		if (screen_check_box.has_focus()):
			_on_ScreenCheckBox_pressed()
		if (exit_btn.has_focus()):
			_on_ReturnToMainMenuButton_pressed()

func _on_ReturnToGameButton_pressed():
	hide()
	get_tree().paused = false

func _on_ReturnToMainMenuButton_pressed():
	Globle.menu_to_return = "StartGame"
	get_tree().change_scene_to_file("res://scenes/Menu/MainMenu.tscn")

func _on_ScreenCheckBox_pressed():
	## TODO Try to figure a way how to keep this unpaused.
	hide()
	get_tree().paused = false
	screen_check_box.grab_focus()
	Globle.game_fullscreen = !Globle.game_fullscreen
