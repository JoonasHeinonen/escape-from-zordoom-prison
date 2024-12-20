extends Control

@onready var player = get_tree().get_root().get_node("Level/player")
@onready var player_ui = get_parent()
@onready var wpns_for_sale_btns = $WeaponsForSale/CenterRow/WeaponsForSaleButtons
@onready var vendor_background_panel = $VendorBackgroundPanel
@onready var vendor_panel = $VendorPanel
@onready var return_btn_container = $ReturnToGameButtonContainer
@onready var return_btn = $ReturnToGameButtonContainer/CenterRow/Buttons/ReturnToGameButton
@onready var weapon_description_panel = $WeaponDescriptionPanel
@onready var weapon_description_panel_children = [
	$WeaponDescriptionPanel/WpnImageContainer,
	$WeaponDescriptionPanel/WeaponDescription
]
@onready var weapon_description_panel_hboxcontainer = $WeaponDescriptionPanel/WpnImageContainer/HBoxContainer

func _ready():
	return_btn.grab_focus()
	hide()

func _process(_delta):
	if (self.name == "VendorContainer"):
		vendor_background_panel.size = Vector2(
			get_viewport().size.x,
			get_viewport().size.y
		)
		vendor_panel.size = Vector2(
			get_viewport().size.x - 140,
			get_viewport().size.y - 140
		)
		return_btn_container.size = Vector2(
			get_viewport().size.x - 140,
			return_btn_container.size.y
		)
		weapon_description_panel.offset_right = get_viewport().size.x - 140
		weapon_description_panel.offset_bottom = get_viewport().size.y - 140
		for child in weapon_description_panel_children:
			child.size.x = get_viewport().size.x - 600
		weapon_description_panel_hboxcontainer.size.x = get_viewport().size.x - 600
	if (self.visible):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_released("ui_accept"):
		if (!Globle.vendor_open):
			return_btn.grab_focus()
			if (Globle.vendor_active == true):
				vendor_process(true, false)
				player_ui.get_node("VendorContainer").show()
		if (Globle.vendor_open):
			if (Globle.vendor_active == false):
				vendor_process(false, true)
				hide()
	if event.is_action_pressed("ui_accept"):
		for btn in wpns_for_sale_btns.get_children():
			if btn.has_focus():
				var wpn_name = btn.text
				var unwanted_chars = [" "]
				
				# Takes the chars from the wpn_for_sale.
				for c in unwanted_chars:
					wpn_name = wpn_name.replace(c, "_")
				wpn_name = wpn_name.to_lower()
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

func vendor_process(open: bool, pause: bool):
	Globle.update_vendor()
	get_tree().paused = open
	get_parent().set_process_input(pause)
