extends Control

onready var player       = get_parent().get_parent()
onready var weapon_slots = [
	$MenuContainer/WeaponSlot1,
	$MenuContainer/WeaponSlot2,
	$MenuContainer/WeaponSlot3,
	$MenuContainer/WeaponSlot4,
	$MenuContainer/WeaponSlot5,
	$MenuContainer/WeaponSlot6,
	$MenuContainer/WeaponSlot7,
	$MenuContainer/WeaponSlot8,
]

var time_scale_target    = 1
var interpolation        = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Hide / show the mouse and the active aiming radical.
	if (self.visible):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	# All the input actions for game's pausing functionality.
	if (!get_tree().paused):
		if event.is_action_pressed("ui_inventory"):
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
							# Pick the player's weapon directly from the inventory.
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
						else:
							print(weapon_slot)
						weapon_slot.grab_focus()

func _physics_process(delta):
	if interpolation <= 1:
		interpolation += delta
	Engine.time_scale = lerp(Engine.time_scale, time_scale_target, interpolation)

# Custom function to determine pausing functionality.
func determine_pause(inventory : bool, scale : int, process_input : bool):
	Globle.player_inventory = inventory
	time_scale_target       = scale
	Engine.time_scale       = scale
	get_parent().set_process_input(process_input)

# To grab focus on the active inventory menu item.
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
