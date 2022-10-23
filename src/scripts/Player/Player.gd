extends KinematicBody

onready var projectile 	  = preload("res://scenes/Projectiles/BlasterProjectile.tscn")
onready var hand_instance = $Sprite3D/HandInstance
onready var camera  	  = $Camera

export var speed 		  = 1

var state_machine
var active_weapon_button

var velocity 			  = Vector3(0,0,0)

var gravity 			  = 4
var jump 				  = 4
var bolt 				  = 0
var current_weapon_index  = 0
var weapons				  = 0

var alive 				  = true
var on_inventory 		  = false

var ray_origin  		  = Vector3()
var ray_end 			  = Vector3()


# Called when the node enters the scene tree for the first time.
func _ready():
	$ShootTimer.connect("timeout", self, "_on_ShootTimer_timeout")
	$ShootTimer.start()
	state_machine = $AnimationTree.get("parameters/playback")
	"""
	for i in $PlayerUI/InventoryContainer.get_children():
			for button in i.get_children():
				
	"""
	$PlayerUI/InventoryContainer.visible = false
	active_weapon_button =  $PlayerUI/InventoryContainer/Button_0/button_0
	walk(0, 1, (-1) * 0.1, -2)

func _physics_process(delta):
	var current = state_machine.get_current_node()
	
	if alive == true && on_inventory == false:
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
		if Input.is_action_just_released("ui_inventory"):
			on_inventory = true
			active_weapon_button.grab_focus()
	elif on_inventory == true:
		if Input.is_action_just_released("ui_inventory"):
			on_inventory = false
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		state_machine.travel("Angela_Fall")
	
	# Return to the main menu.
	if Input.is_action_just_pressed("ui_esc"):
		get_tree().change_scene("res://scenes/Menu/MainMenu.tscn")

	move_and_slide(velocity,Vector3.UP)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var y_position = self.global_transform.origin.y

	# Get current physics state.
	var space_state = get_world().direct_space_state
	
	var ray_length = 100000
	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var result = space_state.intersect_ray( from, to )
	$Sprite3D/MeshInstance.look_at(Vector3(result["position"].x, result["position"].y, result["position"].z), Vector3(0, 0, 1))
	
	# Fall death.
	if y_position < -3:
		# alive = false
		pass

	# Inventory functionalities.
	if on_inventory:
		velocity.x = 0
		state_machine.travel("Angela_Still")
		$PlayerUI/InventoryContainer.visible = true
	else:
		$PlayerUI/InventoryContainer.visible = false

# Limits the shooting rate.
func _on_ShootTimer_timeout():
	if Input.is_action_pressed("ui_ranged_attack"):
		shoot()
		$ShootTimer.start()

# Walking functionality.
func walk(vel, scale, weapon_translation, hand_translation):
	state_machine.travel("Angela_Walk")
	velocity.x = vel
	$Sprite3D.scale.x = scale
	$Sprite3D/MeshInstance.scale.x = weapon_translation
	$Sprite3D/MeshInstance/HandInstance.scale.y = hand_translation
	$Sprite3D/MeshInstance.rotate_x(270)
	# -0.667
	# $Sprite3D/MeshInstance.translation.x = weapon_translation

# Shooting functionality.
func shoot():
	var bullet = projectile.instance()
	bullet.translation.x = 3
	get_parent().add_child(bullet)
	bullet.global_transform = $Sprite3D/MeshInstance/HandInstance/Hand/WeaponPlaceHolder/WeaponMuzzle.global_transform

# Change the current active weapon
func change_weapon(weapon):
	pass

# Used to debug the rotation values.
func debug_rotation_values(x, y, z):
	var values = "Rotation values: %s %s %s."	
	var args = values % [x, y, z]
	print(args)

# Button_0 pressed.
func _on_button_0_pressed():
	active_weapon_button =  $PlayerUI/InventoryContainer/Button_0/button_0
	on_inventory = false

# Button_1 pressed.
func _on_button_1_pressed():
	active_weapon_button =  $PlayerUI/InventoryContainer/Button_1/button_1
	on_inventory = false

# Button_2 pressed.
func _on_button_2_pressed():
	active_weapon_button =  $PlayerUI/InventoryContainer/Button_2/button_2
	on_inventory = false

# Button_3 pressed.
func _on_button_3_pressed():
	active_weapon_button =  $PlayerUI/InventoryContainer/Button_3/button_3
	on_inventory = false

# Button_4 pressed.
func _on_button_4_pressed():
	active_weapon_button =  $PlayerUI/InventoryContainer/Button_4/button_4
	on_inventory = false

# Button_5 pressed.
func _on_button_5_pressed():
	active_weapon_button =  $PlayerUI/InventoryContainer/Button_5/button_5
	on_inventory = false

# Button_6 pressed.
func _on_button_6_pressed():
	active_weapon_button =  $PlayerUI/InventoryContainer/Button_6/button_6
	on_inventory = false

# Button_7 pressed.
func _on_button_7_pressed():
	active_weapon_button =  $PlayerUI/InventoryContainer/Button_7/button_7
	on_inventory = false
