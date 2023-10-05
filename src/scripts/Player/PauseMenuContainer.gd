extends Control

onready var return_btn = $VBoxContainer/CenterRow/Buttons/ReturnToGameButton
onready var exit_btn = $VBoxContainer/CenterRow/Buttons/ReturnToMainMenuButton

var btns : Array = [return_btn, exit_btn]

# Called when the node enters the scene tree for the first time.
func _ready():
	return_btn.grab_focus()
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (self.visible):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event):
	if event.is_action_pressed("ui_esc"):
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
		elif (exit_btn.has_focus()):
			_on_ReturnToMainMenuButton_pressed()

# Returns to the game.
func _on_ReturnToGameButton_pressed():
	hide()
	get_tree().paused = false

# Returns to the main menu.
func _on_ReturnToMainMenuButton_pressed():
	Globle.menu_to_return = "StartGame"
	get_tree().change_scene("res://scenes/Menu/MainMenu.tscn")
