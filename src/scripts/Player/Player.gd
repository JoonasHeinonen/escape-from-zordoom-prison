extends KinematicBody

onready var projectile = preload("res://scenes/Projectiles/BlasterProjectile.tscn")

export var speed = 1

var state_machine

var velocity = Vector3(0,0,0)

var gravity = 4
var jump = 3
var bolt = 0

var alive = true
var on_inventory = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$ShootTimer.connect("timeout", self, "_on_ShootTimer_timeout")
	$ShootTimer.start()
	state_machine = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
	var current = state_machine.get_current_node()
	
	if alive == true && on_inventory == false:
		if Input.is_action_pressed("ui_right") and  Input.is_action_pressed("ui_left"):
			state_machine.travel("Angela_Still")
			velocity.x = 0
		elif Input.is_action_pressed("ui_right"):
			walk(5, 1, 1)
		elif Input.is_action_pressed("ui_left"):
			walk(-5, -1, -1)
		else:
			velocity.x = lerp(velocity.x,0,0.1)
			state_machine.travel("Angela_Still")
		if is_on_floor() and Input.is_action_just_pressed("jump"):
			velocity.y = jump
		if Input.is_action_just_released("ui_home"):
			on_inventory = true
		ranged_combat()
	elif on_inventory == true:
		if Input.is_action_just_released("ui_home"):
			on_inventory = false
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		state_machine.travel("Angela_Fall")

	move_and_slide(velocity,Vector3.UP)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var y_position = self.global_transform.origin.y
	
	# Fall death.
	if y_position < -3:
		alive = false
		
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
func walk(vel, scale, weapon_translation):
	state_machine.travel("Angela_Walk")
	velocity.x = vel
	$Sprite3D.scale.x = scale
	$WeaponPlaceHolder.scale.x = scale
	$WeaponPlaceHolder.translation.x = weapon_translation

# Perform the ranged combat.
func ranged_combat():
	if Input.is_action_pressed("ui_ranged_attack"):
		$WeaponPlaceHolder.visible = true
	else:
		$WeaponPlaceHolder.visible = false

# Shooting functionality.
func shoot():
	var bullet = projectile.instance()
	bullet.translation.x = 3
	get_parent().add_child(bullet)
	bullet.global_transform = $WeaponPlaceHolder/WeaponMuzzle.global_transform
