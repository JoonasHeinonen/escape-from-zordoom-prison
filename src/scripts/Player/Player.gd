extends KinematicBody

const RANDOM_ANGLE		  		 = PI/2.0

onready var projectile 	  		 = preload("res://scenes/Projectiles/BlasterProjectile.tscn")
onready var blitzGunProjectile 	 = preload("res://scenes/Projectiles/BlitzGunProjectile.tscn")
onready var bolt_sparkle 		 = preload("res://scenes/Effects/Collectibles/BoltSparkle.tscn")
onready var gravityBombProjectile = preload("res://scenes/Projectiles/GravityBombProjectile.tscn")
onready var negotiatorProjectile = preload("res://scenes/Projectiles/NegotiatorProjectile.tscn")
onready var gun_btn 	  		 = preload("res://scenes/UI/VendorWeaponButton.tscn")

onready var angela_arm 			 = $AngelaArm
onready var rivet_arm 			 = $RivetArm
onready var camera 		  		 = $Camera
onready var hand_instance_src 	 = "res://resources/images/characters/player/"

export var speed 		  		 = 1

var hand_instance : Sprite3D
var gun_instance
var state_machine
var active_weapon_button

var velocity 			  		 = Vector3(0,0,0)

var gravity 			  		 = 4
var jump 				  		 = 4
var bolt 				  		 = 0

var alive 				  		 = true

# Weapon variables, if player has such weapon.
var current_weapon 		  		 = null

var ray_origin  		  		 = Vector3()
var ray_end 			  		 = Vector3()
var random 				  		 = RandomNumberGenerator.new()
var fire_Rate			  		 = 3

### INHERITED FUNCTIONS FROM GODOT.

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set the state machine and the active sprite.
	if (Globle.player_character == "Rivet"):
		var g_i_s = load(hand_instance_src + "rivet/rivet_weapon.png")				
		state_machine = $RivetAnimationTree.get("parameters/playback")
		gun_instance  = $RivetArm/HandInstance/Hand/WeaponPlaceHolder
		hand_instance = $RivetArm/HandInstance/Hand
		$AngelaArm/HandInstance/Hand/WeaponPlaceHolder.hide()
		$AngelaSprite.hide()
		$RivetSprite.show()
		$AngelaArm.hide()
		$RivetArm.show()
		hand_instance.set_texture(g_i_s)
	elif (Globle.player_character == "Angela"):
		var g_i_s = load(hand_instance_src + "angela/angela_weapon.png")
		state_machine = $AngelaAnimationTree.get("parameters/playback")
		gun_instance  = $AngelaArm/HandInstance/Hand/WeaponPlaceHolder
		hand_instance = $AngelaArm/HandInstance/Hand
		$RivetArm/HandInstance/Hand/WeaponPlaceHolder.hide()
		$AngelaSprite.show()
		$RivetSprite.hide()
		$AngelaArm.show()
		$RivetArm.hide()
		hand_instance.set_texture(g_i_s)
	hand_instance.scale.y = -20

	$ShootTimer.connect("timeout", self, "_on_ShootTimer_timeout")
	$ShootTimer.start()
	$PlayerUI/InventoryContainer.visible = false
	walk(0, 1, -0.1)
	
	# Set the current weapon as edge blaster, if it's available.
	if Globle.current_weapons.size() > 0:
		current_weapon = "edge_blaster"
	set_vendor_weapons(Globle.weapons_for_sale)

func _physics_process(delta):
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
		"blitz_gun":
			change_weapon_texture("blitz_gun")
		"gravity_bomb":
			change_weapon_texture("gravity_bomb")
		"negotiator":
			change_weapon_texture("negotiator")
		"pulse_rifle":
			change_weapon_texture("pulse_rifle")
		"ry3no":
			change_weapon_texture("ry3no")
		"sheepinator":
			change_weapon_texture("sheepinator")
		_:
			gun_instance.hide()

	if alive && !Globle.player_inventory:
		# Melee attack.
		if Input.is_action_pressed("ui_melee_attack"):
			# Disable Rivet's melee attack for now.
			if Globle.player_character != "Rivet":
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
			walk(5, 1, -0.1)
			$RivetArm/HandInstance/Hand.scale.y = -20
			$AngelaArm/HandInstance/Hand.scale.y = -20
			$PlayerHit_box.set_translation(Vector3(0.649, 0, 0))
		elif Input.is_action_pressed("ui_left"):
			walk(-5, -1, 0.1)
			$RivetArm/HandInstance/Hand.scale.y = 20
			$AngelaArm/HandInstance/Hand.scale.y = 20
			$PlayerHit_box.set_translation(Vector3((-0.649 * 3.1), 0, 0))
		else:
			velocity.x = lerp(velocity.x,0,0.1)
			state_machine.travel("Player_Still")
		if is_on_floor() and Input.is_action_just_pressed("jump"):
			velocity.y = jump

	if Input.is_action_just_released("ui_accept"):
		print(Globle.WPNS[0])
		Globle.update_vendor()

	# Disable Rivet's melee attack for now.
	if Globle.player_character != "Rivet":
		if Input.is_action_just_released("ui_melee_attack"):
			Globle.melee_attack = false

	if not is_on_floor():
		velocity.y -= gravity * delta
		state_machine.travel("Player_Fall")
		# Disable Rivet's melee attack for now.
		if Globle.player_character != "Rivet":
			if Input.is_action_pressed("ui_melee_attack"):
				state_machine.travel("Player_Melee")

	set_vendor_weapons(Globle.weapons_for_sale)
	move_and_slide(velocity,Vector3.UP)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var y_position = self.global_transform.origin.y

	# Get current physics state.
	var space_state = get_world().direct_space_state
	
	# Weapon slot index.
	var slot_index = 1

	# Button for melee is pressed once.
	if !Globle.player_inventory:
		var offset = -PI * 0.5
		var screen_pos = get_viewport().get_camera().unproject_position(angela_arm.global_transform.origin)
		var mouse_pos = get_viewport().get_mouse_position()
		var angle = screen_pos.angle_to_point(mouse_pos)
		angela_arm.rotation.x = 0
		angela_arm.rotation.y = 0
		angela_arm.rotation.z = -angle + offset
		rivet_arm.rotation.x = 0
		rivet_arm.rotation.y = 0
		rivet_arm.rotation.z = -angle + offset

	# Hide the hand gun when doing a melee attack.
	angela_arm.hide() if Input.is_action_pressed("ui_melee_attack") else angela_arm.show()
	# Disable Rivet's melee attack for now.
	if Globle.player_character != "Rivet":
		rivet_arm.hide() if Input.is_action_pressed("ui_melee_attack") else rivet_arm.show()
		if Input.is_action_just_pressed("ui_melee_attack") : play_melee_sound(random.randi_range(0,4))

	# Determine inventory items.
	set_weapons_to_inventory(Globle.current_weapons)
	
	# Set the bolts in the vendor.
	$PlayerUI/VendorContainer/WeaponDescriptionPanel/CurrentBolts/CurrentBoltsLabel.text = str(Globle.bolts)

### CUSTOM FUNCTIONS FOR THE PLAYER FUNCTIONALITY.

# Sets all the items to the vendor, i.e. determine all the weapons for sale.
func set_vendor_weapons(weapons_for_sale):
	var vendor_node = $PlayerUI/VendorContainer/WeaponsForSale/CenterRow/Buttons

	for v_n in vendor_node.get_children():
		vendor_node.remove_child(v_n)
		v_n.queue_free()

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
		$PlayerUI/VendorContainer/WeaponsForSale/CenterRow/Buttons.add_child(btn)

# Sets all the in the inventory.
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

# Sets the weapon metadata for the inventory.
func set_weapon_metadata(button: Button, res: TextureRect, weapon_name: String):
	var weapon_sprite_path = "res://resources/images/weapons/" + weapon_name + ".png"
	res.texture = load(weapon_sprite_path)
	button.disabled = false

# Changes the texture of the gun in the hand.
func change_weapon_texture(weapon_name: String):
	var weapon_sprite_path = "res://resources/images/weapons/" + weapon_name + ".png"
	gun_instance.texture = load(weapon_sprite_path)

# Walking functionality.
func walk(vel, scale, mesh_translation):
	state_machine.travel("Player_Walk")
	velocity.x = vel
	if (Globle.player_character == "Angela"):
		$AngelaSprite.scale.x = scale
	elif (Globle.player_character == "Rivet"):
		$RivetSprite.scale.x = scale

# Purchases weapon when a weapon button is pressed.
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

# Updates the vendor data once a weapon is highlighted.
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
	$PlayerUI/VendorContainer/WeaponDescriptionPanel/WpnImageContainer/WpnImageBackground/WpnImage.texture = load(weapon_sprite_path)

# Play the audio for collecting a collectible resource.
func collect_bolt(index : int, type : String):
	# Create the bolt sparkle once a bolt is collected.
	var b_s = bolt_sparkle.instance()
	b_s.global_transform = $CollisionShape.global_transform	
	b_s.scale = Vector3(1, 1, 1)
	b_s.translation.z = 0.1
	get_parent().add_child(b_s)

# For playing the randomized collectible collection sound effect.
	if (type == "bolt"):
		match index:
			0:
				$Audio/Collectibles/Bolt/Bolt0.play()
			1:
				$Audio/Collectibles/Bolt/Bolt1.play()
			2:
				$Audio/Collectibles/Bolt/Bolt2.play()
			_:
				$Audio/Collectibles/Bolt/Bolt0.play()
	elif (type == "ammo"):
		print("Ammo!")
		match index:
			0:
				$Audio/Collectibles/Ammo/Ammo0.play()
			1:
				$Audio/Collectibles/Ammo/Ammo1.play()
			_:
				$Audio/Collectibles/Ammo/Ammo0.play()

# Play the audio for the melee.
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

# Determine whose weapon muzzle to use.
func determine_weapon_muzzle(player : String, bullet):
	match player:
		"Angela":
			bullet.global_transform = $AngelaArm/HandInstance/Hand/WeaponPlaceHolder/WeaponMuzzle.global_transform
		"Rivet":
			bullet.global_transform = $RivetArm/HandInstance/Hand/WeaponPlaceHolder/WeaponMuzzle.global_transform
		_:
			pass

# Shooting functionality for the edge blaster.
func shoot_edge_blaster():
	var bullet = projectile.instance()
	bullet.translation.x = 3
	get_parent().add_child(bullet)
	determine_weapon_muzzle(Globle.player_character, bullet)
	$Audio/EdgeBlaster.play()

# Shooting functionality for the blitz gun.
func shoot_blitz_gun():	
	$Audio/BlizGun.play()
	#bullet spread
	for index in fire_Rate:
		var bullet = blitzGunProjectile.instance()
		bullet.translation.x = 3
		get_parent().add_child(bullet)
		determine_weapon_muzzle(Globle.player_character, bullet)
		bullet.rotate(Vector3(0,0,1),(randf()-.5)*RANDOM_ANGLE)

# Shooting functionality for the gravity bomb.
func shoot_gravity_bomb():
	$Audio/GravityBomb.play()
	print("Gravity will guide this grenade into ground, emerging into explosion!")
	var bullet = gravityBombProjectile.instance()
	bullet.translation.x = 3
	bullet.velocity = $AngelaArm/HandInstance/Hand/WeaponPlaceHolder/WeaponMuzzle.global_transform.basis.x
	get_parent().add_child(bullet)
	bullet.rotate(Vector3(0, 0, 1), (randf() - .5) * RANDOM_ANGLE)
	determine_weapon_muzzle(Globle.player_character, bullet)
	
# Shooting functionality for the negotiator.
func shoot_negotiator():
	$Audio/theNegotiator.play()
	var bullet = negotiatorProjectile.instance()
	bullet.translation.x = 3
	get_parent().add_child(bullet)
	bullet.global_transform = $AngelaSprite/MeshInstance/HandInstance/Hand/WeaponPlaceHolder/WeaponMuzzle.global_transform

# Shooting functionality for the pulse rifle.
func shoot_pulse_rifle():
	print("Marksmanship excercised with the pulse rifle.")

# Shooting functionality for the ry3no.
func shoot_ry3no():
	print("RY3NO!")

# Shooting functionality for the sheepinator.
func shoot_sheepinator():
	print("Sheepinator used. All enemies are converted into sheeps.")

### FUNCTIONS USED FUR DEBUGGING THE PLAYER SCENE. NOT USED IN THE FINAL PRODUCT.

# Used to debug the rotation values.
func debug_rotation_values(x, y, z):
	var values = "Rotation values: %s %s %s."	
	var args = values % [x, y, z]
	print(args)

### THE SIGNAL FUNCTIONS FOR THE `PLAYER.GD`.

# Limits the shooting rate.
func _on_ShootTimer_timeout():
	if Input.is_action_pressed("ui_ranged_attack") && !Input.is_action_pressed("ui_melee_attack"):
		match current_weapon:
			"edge_blaster":
				shoot_edge_blaster()
				$ShootTimer.start()
			"blitz_gun":
				shoot_blitz_gun()
				$ShootTimer.start()
			"gravity_bomb":
				shoot_gravity_bomb()
				$ShootTimer.start()
			"negotiator":
				shoot_negotiator()
				$ShootTimer.start()
			"pulse_rifle":
				shoot_pulse_rifle()
				$ShootTimer.start()
			"ry3no":
				shoot_ry3no()
				$ShootTimer.start()
			"sheepinator":
				shoot_sheepinator()
				$ShootTimer.start()

# Loads the scene defined to a particular button.
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

# Acts when a vendor weapon button is highlighted.
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

# Change weapon to Edge Blaster.
func _on_WeaponSlot1_pressed():
	current_weapon = "edge_blaster"

# Change weapon to Blitz Gun.
func _on_WeaponSlot2_pressed():
	current_weapon = "blitz_gun"

# Change weapon to Gravity Bomb
func _on_WeaponSlot3_pressed():
	current_weapon = "gravity_bomb"

# Change weapon to Negotiator.
func _on_WeaponSlot4_pressed():
	current_weapon = "negotiator"

# Change weapon to Pulse Rifle.
func _on_WeaponSlot5_pressed():
	current_weapon = "pulse_rifle"

# Change weapon to RY3NO.
func _on_WeaponSlot6_pressed():
	current_weapon = "ry3no"

# Change weapon to Sheepinator.
func _on_WeaponSlot7_pressed():
	current_weapon = "sheepinator"

# Empty, for now
func _on_WeaponSlot8_pressed():
	pass # Replace with function body.

func _on_player_mouse_entered():
	print("Player here!")
