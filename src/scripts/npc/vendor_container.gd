extends Control

onready var player     = get_parent().get_parent()
onready var return_btn = $VBoxContainer/CenterRow/Buttons/ReturnToGameButton
onready var btns       = $WeaponsForSale/CenterRow/Buttons

# Called when the node enters the scene tree for the first time.
func _ready():
	return_btn.grab_focus()
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Hide / show the mouse and the active aiming radical.
	if (self.visible):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

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
	if event.is_action_pressed("ui_accept"):
		for btn in btns.get_children():
			if btn.has_focus():
				var wpn_name = btn.text
				var unwanted_chars = [" "]
				
				# Takes the chars from the wpn_for_sale.
				for c in unwanted_chars:
					wpn_name = wpn_name.replace(c, "_")
				wpn_name = wpn_name.to_lower()
				print(wpn_name)
				player._on_Vendor_Choice_pressed(btn, wpn_name)

# Called when ReturnToGameButton is pressed.
func _on_ReturnToGameButton_pressed():
	hide()
	get_tree().paused = false
	Globle.vendor_active = false

# Pauses/unpauses the game and opens/closes the vendor system.
func vendor_process(var open: bool, var pause: bool):
	Globle.update_vendor()
	get_tree().paused = open
	get_parent().set_process_input(pause)
