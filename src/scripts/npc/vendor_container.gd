extends Control

onready var return_btn = $VBoxContainer/CenterRow/Buttons/ReturnToGameButton

# Called when the node enters the scene tree for the first time.
func _ready():
	return_btn.grab_focus()
	hide()

func _input(event):
	if event.is_action_released("ui_accept"):
		if (!Globle.vendor_open):
			return_btn.grab_focus()
			if (Globle.vendor_active == true):
				vendor_process(true, false)
				show()
		if (Globle.vendor_open):
			if (Globle.vendor_active == false):
				vendor_process(false, true)
				hide()

# Called when ReturnToGameButton is pressed.
func _on_ReturnToGameButton_pressed():
	hide()
	get_tree().paused = false
	Globle.vendor_active = false

# Pauses/unpauses the game and opens/closes the vendor system.
func vendor_process(var open: bool, var pause: bool):
	get_tree().paused = open
	get_parent().set_process_input(pause)
