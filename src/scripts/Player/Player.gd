extends KinematicBody

class_name Player

signal update_player_position_to_camera(new_aiming_radical)

const RANDOM_ANGLE = PI / 2.0

onready var gravity_bomb_projectile = preload("res://scenes/Projectiles/GravityBombProjectile.tscn")
onready var projectile = preload("res://scenes/Projectiles/BlasterProjectile.tscn")
onready var blitz_gun_projectile = preload("res://scenes/Projectiles/BlitzGunProjectile.tscn")
onready var bolt_sparkle = preload("res://scenes/Effects/Collectibles/BoltSparkle.tscn")
onready var negotiator_projectile = preload("res://scenes/Projectiles/NegotiatorProjectile.tscn")
onready var miniturret_packed_projectile = preload("res://scenes/Projectiles/MiniturretPackedProjectile.tscn")
onready var pulse_rifle_projectile = preload("res://scenes/Projectiles/PulseRifleProjectile.tscn")
onready var gun_btn = preload("res://scenes/UI/VendorWeaponButton.tscn")
onready var hand_instance_src = "res://resources/images/characters/player/"

onready var angela_arm = $AngelaArm
onready var rivet_arm = $RivetArm
onready var shoot_timer = $ShootTimer
onready var sniping_radical = $SnipingRadical
onready var ui_timer = $PlayerUI/UINotification/Ui_Timer
onready var ui_containers = [
	$PlayerUI/InventoryContainer,
	$PlayerUI/PauseMenuContainer,
	$PlayerUI/VendorContainer,
# $PlayerUI/ArenaMenu
]

export var check_point_enabled = true
export var speed = 1

var animation_player
var gun_instance
var hand_instance : Sprite3D
var spawn_point
var state_machine

var velocity = Vector3(0 ,0 ,0)

var current_boss_name : String = ""

var bolt = 0
var gravity = 4
var jump = 5
var player_health = 4
var player_max_health
var health_node_counter = 0

var boss_fight_active : bool = false
var in_teleport_radius : bool = false
var player_double_jump : bool = false
var player_double_jump_used : bool = false
var player_is_aiming_with_rifle : bool = false
var player_is_just_damaged : bool = false
var ui_notification : bool = false

var sniping_ray

var current_weapon = null
var sniping_raycast = null

var fire_rate : int = 3

var timer = Timer.new()
var random = RandomNumberGenerator.new()

### INHERITED FUNCTIONS FROM GODOT.

func _ready():
	if check_point_enabled == true:
		global_transform.origin = Globle.spawn_point
	if Globle.spawn_point != Vector3.ZERO:
		global_transform.origin = Globle.spawn_point
	$PlayerHit_box.set_translation(Vector3(0.649, 0, 0))
	player_max_health = player_health

	# Set the state machine and the active sprite.
	if (Globle.player_character == "Rivet"):
		var g_i_s = load(hand_instance_src + "rivet/rivet_weapon.png")
		animation_player = $RivetAnimationPlayer
		state_machine = $RivetAnimationTree.get("parameters/playback")
		gun_instance = $RivetArm/HandInstance/Hand/WeaponPlaceHolder
		hand_instance = $RivetArm/HandInstance/Hand
		sniping_raycast = $RivetArm/HandInstance/Hand/WeaponPlaceHolder/SnipingRayCast
		$AngelaArm/HandInstance/Hand/WeaponPlaceHolder.hide()
		$AngelaSprite.hide()
		$RivetSprite.show()
		$AngelaArm.hide()
		$RivetArm.show()
		hand_instance.set_texture(g_i_s)
	elif (Globle.player_character == "Angela"):
		var g_i_s = load(hand_instance_src + "angela/angela_weapon.png")
		animation_player = $AngelaAnimationPlayer
		state_machine = $AngelaAnimationTree.get("parameters/playback")
		gun_instance  = $AngelaArm/HandInstance/Hand/WeaponPlaceHolder
		hand_instance = $AngelaArm/HandInstance/Hand
		sniping_raycast = $AngelaArm/HandInstance/Hand/WeaponPlaceHolder/SnipingRayCast
		$RivetArm/HandInstance/Hand/WeaponPlaceHolder.hide()
		$AngelaSprite.show()
		$RivetSprite.hide()
		$AngelaArm.show()
		$RivetArm.hide()
		hand_instance.set_texture(g_i_s)
	hand_instance.scale.y = -20

	ui_timer.connect("timeout", self, "_on_UI_Timer_timeout")
	shoot_timer.connect("timeout", self, "_on_ShootTimer_timeout")
	shoot_timer.start()
	$PlayerUI/InventoryContainer.visible = false
	walk(0, 1, -0.1)

	if Globle.current_weapons.size() > 0:
		current_weapon = "pulse_rifle"

	set_vendor_weapons(Globle.weapons_for_sale)
	# TODO Invalid set index 'origin' (on base: 'Transform') with value of type 'Transform'.
	# Create a if statement that tries and finds the arena level in the PlayerSpawnArena.
	# Need to get the postion of the playerSpawnArena.
	var arena
	if (get_parent().has_node("arena")):
		arena = get_parent().get_node("arena")

func _physics_process(delta):
	# Set the audio nodes position to share the same position as the player.
	for audio_container_child in $Audio.get_children():
		for audio_child in audio_container_child.get_children():
			if audio_child is AudioStreamPlayer3D:
				audio_child.translation = Vector3(self.translation.x, self.translation.y, 0)
		# TODO Swap this to if audio_container_child.name != "UI":
		if audio_container_child.name == "Collectibles":
			for audio_sub_child in audio_container_child.get_children():
				for audio_child in audio_sub_child.get_children():
					audio_child.translation = Vector3(self.translation.x, self.translation.y, 0)

	# Reset double jump while on the ground.
	if is_on_floor():
		player_double_jump = false
		player_double_jump_used = false

	var current = state_machine.get_current_node()

	# Decide the weapons
	if Globle.current_weapons.size() > 0:
		pass
	else:
		current_weapon = null

	# No weapon in hand if no weapon available.
	match current_weapon:
		"edge_blaster":
			change_weapon_texture("edge_blaster")
			update_ammo_ui(Globle.player_weapons_ammo[0], Globle.WPNS[3][0])
			shoot_timer.wait_time = Globle.WPNS[4][0]
		"blitz_gun":
			change_weapon_texture("blitz_gun")
			update_ammo_ui(Globle.player_weapons_ammo[1], Globle.WPNS[3][1])
			shoot_timer.wait_time = Globle.WPNS[4][1]
		"gravity_bomb":
			change_weapon_texture("gravity_bomb")
			update_ammo_ui(Globle.player_weapons_ammo[2], Globle.WPNS[3][2])
			shoot_timer.wait_time = Globle.WPNS[4][2]
		"negotiator":
			change_weapon_texture("negotiator")
			update_ammo_ui(Globle.player_weapons_ammo[3], Globle.WPNS[3][3])
			shoot_timer.wait_time = Globle.WPNS[4][3]
		"pulse_rifle":
			change_weapon_texture("pulse_rifle")
			update_ammo_ui(Globle.player_weapons_ammo[4], Globle.WPNS[3][4])
			shoot_timer.wait_time = Globle.WPNS[4][4]
		"ry3no":
			change_weapon_texture("ry3no")
			update_ammo_ui(Globle.player_weapons_ammo[5], Globle.WPNS[3][5])
			shoot_timer.wait_time = Globle.WPNS[4][5]
		"sheepinator":
			change_weapon_texture("sheepinator")
			shoot_timer.wait_time = Globle.WPNS[4][6]
		"miniturret_glove":
			change_weapon_texture("miniturret_glove")
			update_ammo_ui(Globle.player_weapons_ammo[7], Globle.WPNS[3][7])
			shoot_timer.wait_time = Globle.WPNS[4][7]
		_:
			gun_instance.hide()

	if player_health > 0 && !Globle.player_inventory && !player_is_aiming_with_rifle:
		if Input.is_action_pressed("ui_melee_attack"):
			if Globle.player_character == "Rivet":
				state_machine.travel("Player_Melee")
				if (state_machine.get_current_play_position() > 0.3):
					Globle.melee_attack = true
				if (state_machine.get_current_play_position() >= 0.4):
					Globle.melee_attack = false
					if velocity.x > 0:
						velocity.x -= 0.1
					if velocity.x < 0:
						velocity.x += 0.1
			if Globle.player_character == "Angela":
				state_machine.travel("Player_Melee")
				if (state_machine.get_current_play_position() > 0.3):
					Globle.melee_attack = true
				if (state_machine.get_current_play_position() >= 0.4):
					Globle.melee_attack = false
					if velocity.x > 0:
						velocity.x -= 0.1
					if velocity.x < 0:
						velocity.x += 0.1
		elif Input.is_action_pressed("ui_right"):
			walk(7, 1, -0.1)
			$RivetArm/HandInstance/Hand.scale.y = -20
			$AngelaArm/HandInstance/Hand.scale.y = -20
			$PlayerHit_box.set_translation(Vector3(0.649, 0, 0))
		elif Input.is_action_pressed("ui_left"):
			walk(-7, -1, 0.1)
			$RivetArm/HandInstance/Hand.scale.y = 20
			$AngelaArm/HandInstance/Hand.scale.y = 20
			$PlayerHit_box.set_translation(Vector3((-0.649 * 3.1), 0, 0))
		else:
			velocity.x = lerp(velocity.x,0,0.1)
			state_machine.travel("Player_Still")
		if is_on_floor() and Input.is_action_pressed("jump"):
			velocity.y = jump
		if !player_double_jump_used:
			if (Input.is_action_just_pressed("jump") &&
				player_double_jump &&
				!is_on_floor()
			):
				velocity.y = jump
				player_double_jump = false
				player_double_jump_used = true
			if (Input.is_action_just_released("jump") && !is_on_floor()):
				player_double_jump = true

	if Input.is_action_just_released("ui_accept"):
		Globle.update_vendor()

	if Input.is_action_pressed("ui_ranged_sniper_aim") && !Input.is_action_pressed("ui_melee_attack"):
		if (current_weapon == "pulse_rifle"):
			update_player_position_to_camera()
			player_is_aiming_with_rifle = true
	elif Input.is_action_just_released("ui_ranged_sniper_aim") && !Input.is_action_pressed("ui_melee_attack"):
			player_is_aiming_with_rifle = false
	if (!player_is_aiming_with_rifle):
		sniping_raycast.hide()
		sniping_radical.hide()
	else:
		sniping_raycast.show()
		sniping_radical.show()

	if not is_on_floor():
		velocity.y -= gravity * delta
		state_machine.travel("Player_Fall")
		if Globle.player_character == "Angela":
			if Input.is_action_pressed("ui_melee_attack"):
				state_machine.travel("Player_Melee")
		if Globle.player_character == "Rivet":
			if Input.is_action_pressed("ui_melee_attack"):
				state_machine.travel("Player_Melee")

	set_vendor_weapons(Globle.weapons_for_sale)
	move_and_slide(velocity, Vector3.UP)

func _process(delta):
	var y_position = self.global_transform.origin.y
	var space_state = get_world().direct_space_state
	var slot_index = 1

	for ui_container in ui_containers:
		if (ui_container.visible):
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		elif (player_is_aiming_with_rifle):
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if player_health <= 0:
		$PlayerUI.hide()
		$FadeIn.show()
		$FadeIn.fade_in()

	# Button for melee is pressed once.
	if !Globle.player_inventory:
		var offset = -PI * 0.5
		var screen_pos = get_viewport().get_camera().unproject_position(angela_arm.global_transform.origin)
		var mouse_pos = get_viewport().get_mouse_position()
		var angle = screen_pos.angle_to_point(mouse_pos)

		if (current_weapon != "pulse_rifle" && !player_is_aiming_with_rifle):
			rotate_arm(0, 0, -angle + offset)
		elif (current_weapon == "pulse_rifle" && player_is_aiming_with_rifle):
			rotate_arm(0, 0, -angle + offset)
		elif (current_weapon == "pulse_rifle" && !player_is_aiming_with_rifle):
			rotate_arm(0, 0, 0)

	if Globle.player_character == "Angela":
		angela_arm.hide() if Input.is_action_pressed("ui_melee_attack") else angela_arm.show()
	if Globle.player_character == "Rivet":
		rivet_arm.hide() if Input.is_action_pressed("ui_melee_attack") else rivet_arm.show()
	if Input.is_action_just_pressed("ui_melee_attack") : play_melee_sound(random.randi_range(0,4))

	if !boss_fight_active: 
		$PlayerUI/UIBossData.visible = false

	if Globle.arena_menu_open : $PlayerUI/ArenaMenu.opens_menu()
	heal_player()
	update_health_ui()
	set_weapons_to_inventory(Globle.current_weapons)
	$PlayerUI/UIBossData/UIBossDataCenterContainer.rect_size = Vector2(get_viewport().size.x, 180)
	$PlayerUI/VendorContainer/WeaponDescriptionPanel/CurrentBolts/CurrentBoltsLabel.text = str(Globle.bolts)

### CUSTOM FUNCTIONS FOR THE PLAYER FUNCTIONALITY.

func init_boss_fight(
	boss_name : String,
	boss_health,
	boss_data_name : String,
	boss_max_health : int
):
	var boss_hud_img_path = "res://resources/images/characters/npc/enemies/bosses/" + boss_data_name + "_boss_fight_icon.png"
	current_boss_name = boss_name

	if boss_fight_active: 
		$PlayerUI/UIBossData.visible = true
		$PlayerUI/UIBossData/UIBossDataCenterContainer/CenterContainer/BossHealthBar.value = int(boss_health)
		$PlayerUI/UIBossData/UIBossDataCenterContainer/CenterContainer/BossHealthPercentage.text = str(int(boss_health)) + " %"
		$PlayerUI/UIBossData/UIBossDataCenterContainer/CenterContainer/BossIconHolder.texture = load(boss_hud_img_path)
		$PlayerUI/UIBossData/UIBossDataCenterContainer/CenterContainer/BossName.text = boss_name

func set_vendor_weapons(weapons_for_sale):
	var vendor_node = $PlayerUI/VendorContainer/WeaponsForSale/CenterRow/WeaponsForSaleButtons

	for v_n in vendor_node.get_children():
		vendor_node.remove_child(v_n)
		v_n.queue_free()

	set_vendor_weapons_data(weapons_for_sale, $PlayerUI/VendorContainer/WeaponsForSale/CenterRow/WeaponsForSaleButtons)

func set_vendor_weapons_data(weapons_for_sale, data):
	for wpn_for_sale in weapons_for_sale:
		var wpn_name = ""
		var unwanted_chars = ["_"]
		var btn = gun_btn.instance()
		btn.set_wpn_for_sale(wpn_for_sale)

		# Takes the chars from the wpn_for_sale.
		for c in unwanted_chars:
			wpn_name = wpn_for_sale.replace(c, " ")
		wpn_name = wpn_name.to_upper()

		btn.set_label(wpn_name)
		btn.connect("pressed", self, "_on_Vendor_Choice_pressed", [btn, btn.wpn_for_sale])
		btn.connect("focus_entered", self, "_on_VendorWeaponButton_focus_entered", [btn, btn.wpn_for_sale])
		data.add_child(btn)

func set_weapons_to_inventory(weapons):
	for weapon in weapons:
		if (weapon == "edge_blaster"):
			set_weapon_metadata(
				$PlayerUI/InventoryContainer/MenuContainer/WeaponSlot1,
				$PlayerUI/InventoryContainer/MenuContainer/WeaponSlot1/SlotTexture,
				"edge_blaster"
			)
		if (weapon == "blitz_gun"):
			set_weapon_metadata(
				$PlayerUI/InventoryContainer/MenuContainer/WeaponSlot2,
				$PlayerUI/InventoryContainer/MenuContainer/WeaponSlot2/SlotTexture,
				"blitz_gun"
			)
		if (weapon == "gravity_bomb"):
			set_weapon_metadata(
				$PlayerUI/InventoryContainer/MenuContainer/WeaponSlot3,
				$PlayerUI/InventoryContainer/MenuContainer/WeaponSlot3/SlotTexture,
				"gravity_bomb"
			)
		if (weapon == "negotiator"):
			set_weapon_metadata(
				$PlayerUI/InventoryContainer/MenuContainer/WeaponSlot4,
				$PlayerUI/InventoryContainer/MenuContainer/WeaponSlot4/SlotTexture,
				"negotiator"
			)
		if (weapon == "pulse_rifle"):
			set_weapon_metadata(
				$PlayerUI/InventoryContainer/MenuContainer/WeaponSlot5,
				$PlayerUI/InventoryContainer/MenuContainer/WeaponSlot5/SlotTexture,
				"pulse_rifle"
			)
		if (weapon == "ry3no"):
			set_weapon_metadata(
				$PlayerUI/InventoryContainer/MenuContainer/WeaponSlot6,
				$PlayerUI/InventoryContainer/MenuContainer/WeaponSlot6/SlotTexture,
				"ry3no"
			)
		if (weapon == "sheepinator"):
			set_weapon_metadata(
				$PlayerUI/InventoryContainer/MenuContainer/WeaponSlot7,
				$PlayerUI/InventoryContainer/MenuContainer/WeaponSlot7/SlotTexture,
				"sheepinator"
			)
		if (weapon == "miniturret_glove"):
			set_weapon_metadata(
				$PlayerUI/InventoryContainer/MenuContainer/WeaponSlot8,
				$PlayerUI/InventoryContainer/MenuContainer/WeaponSlot8/SlotTexture,
				"miniturret_glove"
			)

func set_weapon_metadata(button: Button, res: TextureRect, weapon_name: String):
	var weapon_sprite_path = "res://resources/images/weapons/" + weapon_name + ".png"
	res.texture = load(weapon_sprite_path)
	button.disabled = false

func change_weapon_texture(weapon_name : String):
	var weapon_sprite_path = "res://resources/images/weapons/" + weapon_name + ".png"
	gun_instance.texture = load(weapon_sprite_path)
	gun_instance.show()

func walk(vel, scale, _mesh_translation):
	state_machine.travel("Player_Walk")
	velocity.x = vel
	if (Globle.player_character == "Angela"):
		$AngelaSprite.scale.x = scale
	elif (Globle.player_character == "Rivet"):
		$RivetSprite.scale.x = scale

func rotate_arm(x_val : float, y_val : float, z_val : float):
	angela_arm.rotation.x = x_val
	angela_arm.rotation.y = y_val
	angela_arm.rotation.z = z_val
	rivet_arm.rotation.x = x_val
	rivet_arm.rotation.y = y_val
	rivet_arm.rotation.z = z_val

func purchase_weapon(wpn_price : int, wpn, btn):
	if (Globle.bolts >= wpn_price):
		Globle.current_weapons.append(wpn)
		Globle.update_vendor()
		Globle.bolts -= wpn_price
		btn.queue_free()
		set_vendor_weapons(Globle.weapons_for_sale)
		$PlayerUI/VendorContainer/WeaponDescriptionPanel/CurrentBolts/CurrentBoltsLabel.text = str(Globle.bolts)
	else:
		print("Insufficient funds...")
		## TODO Replace with a UI notification message.

func update_vendor_data(wpn_name, wpn_price : int, wpn_desc):
	var wpn_name_to_label = ""
	var unwanted_chars = ["_"]

	# Takes the chars from the wpn_for_sale.
	for c in unwanted_chars:
		wpn_name_to_label = wpn_name.replace(c, " ")
	wpn_name_to_label = wpn_name_to_label.to_upper()

	var weapon_sprite_path = "res://resources/images/weapons/vendor/" + wpn_name + "_vendor.png"
	$PlayerUI/VendorContainer/WeaponDescriptionPanel/HBoxContainer/WeaponPrice.text = str(wpn_price)
	$PlayerUI/VendorContainer/WeaponDescriptionPanel/WeaponDescription.text = str(wpn_desc)
	$PlayerUI/VendorContainer/WeaponDescriptionPanel/WeaponName.text = str(wpn_name_to_label)
	$PlayerUI/VendorContainer/WeaponDescriptionPanel/WpnImageContainer/HBoxContainer/WpnImageBackground/WpnImage.texture = load(weapon_sprite_path)

func update_health_ui():
	$PlayerUI/InGameUI/Health/HealthHas.text = str(player_health)
	$PlayerUI/InGameUI/Health/HealthMax.text = str(player_max_health)

func collect_collectible(index : int, type : String):
	# Create the bolt sparkle once a bolt is collected.
	var b_s = bolt_sparkle.instance()
	b_s.global_transform = $CollisionShape.global_transform
	b_s.scale = Vector3(1, 1, 1)
	b_s.translation.z = 0.1
	get_parent().add_child(b_s)

	match (type):
		"bolt":
			match index:
				0:
					$Audio/Collectibles/Bolt/Bolt0.play()
				1:
					$Audio/Collectibles/Bolt/Bolt1.play()
				2:
					$Audio/Collectibles/Bolt/Bolt2.play()
				_:
					$Audio/Collectibles/Bolt/Bolt0.play()
		"ammo":
			# TODO Add ammo, depending on the weapons the player has.
			match index:
				0:
					$Audio/Collectibles/Ammo/Ammo0.play()
				1:
					$Audio/Collectibles/Ammo/Ammo1.play()
				_:
					$Audio/Collectibles/Ammo/Ammo0.play()

func heal_player():
	# Adds health if 4 nodes are collected.
	if (health_node_counter == 4):
		# TODO Increase the health once the health logic has been implemented.
		health_node_counter = 0
		player_health += 2
		if (player_health > player_max_health):
			player_health = player_max_health

func damage_player(damage : int):
	if (!player_is_just_damaged):
		player_is_just_damaged = true
		animation_player.play("Player_Damage")
		player_health -= damage
		$DamageCooloffTimer.start()

func ui_notification_msg(ammo : int, weapon_name : String):
	var msg : String = "You got %s ammo for %s"
	$PlayerUI/UINotification/CanvasLayer/Ui_notification.show()
	$PlayerUI/UINotification/CanvasLayer/Ui_notification/ui_ammo.text = msg % [ammo, weapon_name]
	ui_timer.start()
	ui_notification = true

func play_melee_sound(melee_index : int):
	match melee_index:
		0:
			$Audio/Melee/Melee0.play()
		1:
			$Audio/Melee/Melee1.play()
		2:
			$Audio/Melee/Melee2.play()
		3:
			$Audio/Melee/Melee3.play()
		_:
			$Audio/Melee/Melee0.play()

func determine_character_weapon_muzzle(player : String, bullet):
	match player:
		"Angela":
			bullet.global_transform = $AngelaArm/HandInstance/Hand/WeaponPlaceHolder/WeaponMuzzle.global_transform
		"Rivet":
			bullet.global_transform = $RivetArm/HandInstance/Hand/WeaponPlaceHolder/WeaponMuzzle.global_transform
		_:
			pass

func shoot_edge_blaster():
	$Audio/Weapons/EdgeBlaster.play()
	var bullet = projectile.instance()
	bullet.translation.x = 3
	get_parent().add_child(bullet)
	determine_character_weapon_muzzle(Globle.player_character, bullet)

func shoot_blitz_gun():
	$Audio/Weapons/BlizGun.play()
	# Bullet spread.
	for index in fire_rate:
		var bullet = blitz_gun_projectile.instance()
		bullet.translation.x = 3
		get_parent().add_child(bullet)
		determine_character_weapon_muzzle(Globle.player_character, bullet)
		bullet.rotate(Vector3(0,0,1),(randf()-.5)*RANDOM_ANGLE)

func shoot_gravity_bomb():
	$Audio/Weapons/GravityBomb.play()
	var bullet = gravity_bomb_projectile.instance()
	bullet.translation.x = 3
	bullet.velocity = $AngelaArm/HandInstance/Hand/WeaponPlaceHolder/WeaponMuzzle.global_transform.basis.x
	get_parent().add_child(bullet)
	bullet.rotate(Vector3(0, 0, 1), (randf() - .5) * RANDOM_ANGLE)
	determine_character_weapon_muzzle(Globle.player_character, bullet)
	
func shoot_negotiator():
	$Audio/Weapons/theNegotiator.play()
	var bullet = negotiator_projectile.instance()
	bullet.translation.x = 3
	get_parent().add_child(bullet)
	bullet.global_transform = $AngelaArm/HandInstance/Hand/WeaponPlaceHolder/WeaponMuzzle.global_transform

func shoot_pulse_rifle():
	if (player_is_aiming_with_rifle):
		$Audio/Weapons/PulseRifle.play()
		var projectile = pulse_rifle_projectile.instance()
		projectile.translation.x = 10
		get_parent().add_child(projectile)
		projectile.global_transform = $AngelaArm/HandInstance/Hand/WeaponPlaceHolder/WeaponMuzzle.global_transform

func shoot_ry3no():
	print("RY3NO!")

func shoot_sheepinator():
	print("Sheepinator used. All enemies are converted into sheeps.")

func shoot_miniturret_glove():
	var bullet = miniturret_packed_projectile.instance()
	bullet.translation.x = 3
	bullet.velocity = $AngelaArm/HandInstance/Hand/WeaponPlaceHolder/WeaponMuzzle.global_transform.basis.x
	get_parent().add_child(bullet)
	bullet.rotate(Vector3(0, 0, 1), (randf() - .5) * RANDOM_ANGLE)
	determine_character_weapon_muzzle(Globle.player_character, bullet)

### FUNCTIONS USED FUR DEBUGGING THE PLAYER SCENE. NOT USED IN THE FINAL PRODUCT.

func debug_rotation_values(x, y, z):
	var values = "Rotation values: %s %s %s."	
	var args = values % [x, y, z]
	print(args)

### THE SIGNAL FUNCTIONS FOR THE `PLAYER.GD`.

func _on_UI_Timer_timeout():
	if (ui_notification):
		ui_notification = false
		$PlayerUI/UINotification/CanvasLayer/Ui_notification.hide()

func _on_ShootTimer_timeout():
	if Input.is_action_pressed("ui_ranged_attack") && !Input.is_action_pressed("ui_melee_attack"):
		match current_weapon:
			"edge_blaster":
				if (Globle.player_weapons_ammo[0] > 0):
					shoot_edge_blaster()
					shoot_gun(0)
			"blitz_gun":
				if (Globle.player_weapons_ammo[1] > 0):
					shoot_blitz_gun()
					shoot_gun(1)
			"gravity_bomb":
				if (Globle.player_weapons_ammo[2] > 0):
					shoot_gravity_bomb()
					shoot_gun(2)
			"negotiator":
				if (Globle.player_weapons_ammo[3] > 0):
					shoot_negotiator()
					shoot_gun(3)
			"pulse_rifle":
				if (Globle.player_weapons_ammo[4] > 0):
					shoot_pulse_rifle()
					shoot_gun(4)
			"ry3no":
				if (Globle.player_weapons_ammo[5] > 0):
					shoot_ry3no()
					shoot_gun(5)
			"sheepinator":
				shoot_sheepinator()
				shoot_timer.start()
				shoot_timer.wait_time = 2
			"miniturret_glove":
				if (Globle.player_weapons_ammo[7] > 0):
					shoot_miniturret_glove()
					shoot_gun(7)

func shoot_gun(index : int):
	shoot_timer.start()
	shoot_timer.wait_time = Globle.WPNS[4][index]
	if (current_weapon != "pulse_rifle" && !player_is_aiming_with_rifle):
		Globle.player_weapons_ammo[index] -= 1
	elif (current_weapon == "pulse_rifle" && player_is_aiming_with_rifle):
		Globle.player_weapons_ammo[index] -= 1
	update_ammo_ui(Globle.player_weapons_ammo[index], Globle.WPNS[3][index])

func update_ammo_ui(has_ammo : int, max_ammo : int):
	$PlayerUI/InGameUI/Ammo/AmmoHas.text = str(has_ammo)
	$PlayerUI/InGameUI/Ammo/AmmoMax.text = str(max_ammo)

func _on_Vendor_Choice_pressed(button, wpn):
	match (wpn):
		"edge_blaster":
			purchase_weapon(Globle.WPNS[1][0], wpn, button)
		"blitz_gun":
			purchase_weapon(Globle.WPNS[1][1], wpn, button)
		"gravity_bomb":
			purchase_weapon(Globle.WPNS[1][2], wpn, button)
		"negotiator":
			purchase_weapon(Globle.WPNS[1][3], wpn, button)
		"pulse_rifle":
			purchase_weapon(Globle.WPNS[1][4], wpn, button)
		"ry3no":
			purchase_weapon(Globle.WPNS[1][5], wpn, button)
		"sheepinator":
			purchase_weapon(Globle.WPNS[1][6], wpn, button)
		"miniturret_glove":
			purchase_weapon(Globle.WPNS[1][7], wpn, button)

func _on_VendorWeaponButton_focus_entered(button: Button, wpn):
	match (wpn):
		"edge_blaster":
			update_vendor_data(
				Globle.WPNS[0][0],
				Globle.WPNS[1][0],
				Globle.WPNS[2][0]
			)
		"blitz_gun":
			update_vendor_data(
				Globle.WPNS[0][1],
				Globle.WPNS[1][1],
				Globle.WPNS[2][1]
			)
		"gravity_bomb":
			update_vendor_data(
				Globle.WPNS[0][2],
				Globle.WPNS[1][2],
				Globle.WPNS[2][2]
			)
		"negotiator":
			update_vendor_data(
				Globle.WPNS[0][3],
				Globle.WPNS[1][3],
				Globle.WPNS[2][3]
			)
		"pulse_rifle":
			update_vendor_data(
				Globle.WPNS[0][4],
				Globle.WPNS[1][4],
				Globle.WPNS[2][4]
			)
		"ry3no":
			update_vendor_data(
				Globle.WPNS[0][5],
				Globle.WPNS[1][5],
				Globle.WPNS[2][5]
			)
		"sheepinator":
			update_vendor_data(
				Globle.WPNS[0][6],
				Globle.WPNS[1][6],
				Globle.WPNS[2][6]
			)
		"miniturret_glove":
			update_vendor_data(
				Globle.WPNS[0][7],
				Globle.WPNS[1][7],
				Globle.WPNS[2][7]
			)

func update_player_position_to_camera():
	emit_signal("update_player_position_to_camera", player_health)

func _on_WeaponSlot1_pressed():
	current_weapon = "edge_blaster"

func _on_WeaponSlot2_pressed():
	current_weapon = "blitz_gun"

func _on_WeaponSlot3_pressed():
	current_weapon = "gravity_bomb"

func _on_WeaponSlot4_pressed():
	current_weapon = "negotiator"

func _on_WeaponSlot5_pressed():
	current_weapon = "pulse_rifle"

func _on_WeaponSlot6_pressed():
	current_weapon = "ry3no"

func _on_WeaponSlot7_pressed():
	current_weapon = "sheepinator"

func _on_WeaponSlot8_pressed():
	current_weapon = "miniturret_glove"

func _on_CollisionArea_area_entered(area):
	if area.name == "death":
		player_health = 0

func _on_FadeIn_fade_finished():
	get_tree().reload_current_scene()

func _on_DamageCooloffTimer_timeout():
	player_is_just_damaged = false
