extends Control

onready var return_btn = $VBoxContainer/CenterRow/Buttons/ReturnToGameButton

# Called when the node enters the scene tree for the first time.
func _ready():
	return_btn.grab_focus()
	hide()

func _input(event):
	if event.is_action_pressed("ui_esc"):
		if (!Globle.player_inventory):
			return_btn.grab_focus()
			show() if !self.visible else hide()

func _physics_process(delta):
	if (self.visible):
		get_tree().paused = true
	else:
		get_tree().paused = false

# Returns to the game.
func _on_ReturnToGameButton_pressed():
	hide()

# Returns to the main menu.
func _on_ReturnToMainMenuButton_pressed():
	get_tree().change_scene("res://scenes/Menu/MainMenu.tscn")
