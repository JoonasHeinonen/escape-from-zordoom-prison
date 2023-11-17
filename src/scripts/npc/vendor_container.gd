extends Control

onready var player = get_parent().get_parent()
onready var player_ui = get_parent()
onready var return_btn = $VBoxContainer/CenterRow/Buttons/ReturnToGameButton
onready var btns = $WeaponsForSale/CenterRow/Buttons

func _ready():
	return_btn.grab_focus()
	hide()

func _process(_delta):
	if (self.visible):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_released("ui_accept"):
		if (!Globle.vendor_open):
			return_btn.grab_focus()
			if (Globle.vendor_active == true):
				vendor_process(true, false)
				if (Globle.game_fullscreen):
					player_ui.get_node("FullscreenVendorContainer").show()
					player_ui.get_node("VendorContainer").hide()
					print("Fullscreen")
				elif (!Globle.game_fullscreen):
					player_ui.get_node("FullscreenVendorContainer").hide()
					player_ui.get_node("VendorContainer").show()
					print("Not fullscreen")
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
	if event.is_action_pressed("ui_esc"):
		if (Globle.vendor_active):
			vendor_process(false, false)
			hide()
	if event.is_action_released("ui_esc"):
		if (Globle.vendor_active):
			player_ui.get_node("PauseMenuContainer").hide()
			vendor_process(false, false)

func _on_ReturnToGameButton_pressed():
	hide()
	get_tree().paused = false
	Globle.vendor_active = false

func vendor_process(var open: bool, var pause: bool):
	Globle.update_vendor()
	get_tree().paused = open
	get_parent().set_process_input(pause)
