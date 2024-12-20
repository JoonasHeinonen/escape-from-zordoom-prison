extends MenuSceneControlBase

@onready var player = get_tree().get_root().get_node("Level/player")

var weapon_slots = []

func _ready():
	weapon_slots = [
		$MenuContainer/WeaponSlot1,
		$MenuContainer/WeaponSlot2,
		$MenuContainer/WeaponSlot3,
		$MenuContainer/WeaponSlot4,
		$MenuContainer/WeaponSlot5,
		$MenuContainer/WeaponSlot6,
		$MenuContainer/WeaponSlot7,
		$MenuContainer/WeaponSlot8,
	]
	hide()

func _process(_delta):
	if (self.visible):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if (!get_tree().paused):
		if event.is_action_pressed("ui_inventory") and Globle.player_active == true:
			determine_pause(true, 0, false)
			show()
			if (player.current_weapon != null):
				determine_active_item(player.current_weapon)
		if event.is_action_released("ui_inventory"):
			determine_pause(false, 1, true)
			hide()
		if event.is_action_pressed("ui_accept"):
			if Globle.player_inventory:
				for weapon_slot in weapon_slots:
					if (weapon_slot.has_focus()):
						var slot_texture = weapon_slot.get_node("SlotTexture")
						if slot_texture.texture != null:
							match weapon_slot.name:
								"WeaponSlot1":
									player.current_weapon = "edge_blaster"
								"WeaponSlot2":
									player.current_weapon = "blitz_gun"
								"WeaponSlot3":
									player.current_weapon = "gravity_bomb"
								"WeaponSlot4":
									player.current_weapon = "negotiator"
								"WeaponSlot5":
									player.current_weapon = "pulse_rifle"
								"WeaponSlot6":
									player.current_weapon = "ry3no"
								"WeaponSlot7":
									player.current_weapon = "sheepinator"
								"WeaponSlot8":
									player.current_weapon = "miniturret_glove"
							determine_pause(false, 1, true)
							hide()
						weapon_slot.grab_focus()

func _physics_process(delta):
	if interpolation <= 1.0:
		interpolation += delta
	Engine.time_scale = lerp(Engine.time_scale, 1.0, interpolation)

func determine_pause(inventory : bool, _scale : int, process_input : bool):
	Globle.player_inventory = inventory

func determine_active_item(weapon : String):
	match weapon:
		"edge_blaster":
			$MenuContainer/WeaponSlot1.grab_focus()
		"blitz_gun":
			$MenuContainer/WeaponSlot2.grab_focus()
		"gravity_bomb":
			$MenuContainer/WeaponSlot3.grab_focus()
		"negotiator":
			$MenuContainer/WeaponSlot4.grab_focus()
		"pulse_rifle":
			$MenuContainer/WeaponSlot5.grab_focus()
		"ry3no":
			$MenuContainer/WeaponSlot6.grab_focus()
		"sheepinator":
			$MenuContainer/WeaponSlot7.grab_focus()
		"miniturret_glove":
			$MenuContainer/WeaponSlot8.grab_focus()
