extends KinematicBody

onready var projectile 	  = preload("res://scenes/Projectiles/BlasterProjectile.tscn")
onready var hand_instance = $Sprite3D/HandInstance
onready var gun_instance  = $Sprite3D/MeshInstance/HandInstance/Hand/WeaponPlaceHolder
onready var camera 		  = $Camera

export var speed 		  = 1

var state_machine
var active_weapon_button

var velocity 			  = Vector3(0,0,0)

var gravity 			  = 4
var jump 				  = 4
var bolt 				  = 0

var alive 				  = true

# Weapon variables, if player has such weapon.
var current_weapon 		  = null

var ray_origin  		  = Vector3()
var ray_end 			  = Vector3()

### INHERITED FUNCTIONS FROM GODOT.

# Called when the node enters the scene tree for the first time.
func _ready():
	$ShootTimer.connect("timeout", self, "_on_ShootTimer_timeout")
	$ShootTimer.start()
	state_machine = $AnimationTree.get("parameters/playback")
	$PlayerUI/InventoryContainer.visible = false
	walk(0, 1, (-1) * 0.1, -2)
	
	
	
	# Set the current weapon as edge blaster, if it's available.
	if Globle.current_weapons.size() > 0:
		current_weapon = "edge_blaster"

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
		if Input.is_action_pressed("ui_right") and  Input.is_action_pressed("ui_left"):
			state_machine.travel("Angela_Still")
			velocity.x = 0
		elif Input.is_action_pressed("ui_right"):
			walk(5, 1, (-1) * 0.1, -2)
		elif Input.is_action_pressed("ui_left"):
			walk(-5, -1, 0.1, 2)
		else:
			velocity.x = lerp(velocity.x,0,0.1)
			state_machine.travel("Angela_Still")
		if is_on_floor() and Input.is_action_just_pressed("jump"):
			velocity.y = jump

	if not is_on_floor():
		velocity.y -= gravity * delta
		state_machine.travel("Angela_Fall")
	
	move_and_slide(velocity,Vector3.UP)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var y_position = self.global_transform.origin.y

	# Get current physics state.
	var space_state = get_world().direct_space_state
	
	# Weapon slot index.
	var slot_index = 1
	
	var ray_length = 100000
	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var result = space_state.intersect_ray(from, to)
	#button for melee is pressed once.
	if !Globle.player_inventory:
		$Sprite3D/MeshInstance.look_at(Vector3(result["position"].x, result["position"].y, result["position"].z), Vector3(0, 0, 1))
		
	# Determine inventory items.
	set_weapons_to_inventory(Globle.current_weapons)

### CUSTOM FUNCTIONS FOR THE PLAYER FUNCTIONALITY.
## melee combat fuction
# goal for next week have detait that the modle has entered the hurt box
#then once the player press f or the melee button
#the box is distroyed then the box produces bolts
"""
func meleeCombat(amount:int)-> void):
	if Input.is_action_just_pressed("ui_melee_attack"):
		print("Melee button is pressed")
"""

		
		
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
func walk(vel, scale, weapon_translation, hand_translation):
	state_machine.travel("Angela_Walk")
	velocity.x = vel
	$Sprite3D.scale.x = scale
	$Sprite3D/MeshInstance.scale.x = weapon_translation
	$Sprite3D/MeshInstance/HandInstance.scale.y = hand_translation
	$Sprite3D/MeshInstance.rotate_x(270)

# Shooting functionality for the edge blaster.
func shoot_edge_blaster():
	var bullet = projectile.instance()
	bullet.translation.x = 3
	get_parent().add_child(bullet)
	bullet.global_transform = $Sprite3D/MeshInstance/HandInstance/Hand/WeaponPlaceHolder/WeaponMuzzle.global_transform

# Shooting functionality for the blitz gun.
func shoot_blitz_gun():
	print("Blizzard and blitz!")

# Shooting functionality for the gravity bomb.
func shoot_gravity_bomb():
	print("Gravity will guide this grenade into ground, emerging into explosion!")

# Shooting functionality for the negotiator.
func shoot_negotiator():
	print("You have negotiated your enemies... To surrender...")

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
	if Input.is_action_pressed("ui_ranged_attack"):
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
