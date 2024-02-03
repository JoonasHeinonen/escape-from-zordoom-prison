extends EnemyBase

@onready var laser_attack_scene = preload("res://scenes/Projectiles/nef_head_laser.tscn")
@onready var player_finding_raycast = $EnemySprite/player_finding
@onready var ground_finding_raycast = $EnemySprite/ground_finding

var value : int  = 0
var attack_delay : int = 2
var can_shoot : bool = true
var isFlipping : bool = false
var is_moving_left : bool = true
var target : Player = null
var attack = null
var timer = null

# try and roate the ray cast without using the animation player


# Fix lock on redical.
# refactor speed variable
func _ready():
	element = elements.AIR
	gravity = -4
	speed = 2
	timer = Timer.new()
	timer.connect("timeout", Callable(self, "nef_head_shoot_time"))
	timer.wait_time = 1
	timer.one_shot = true
	add_child(timer)
	timer.start()
	meta_name = "nef_head"
	self.set_meta("type", "enemy")
	self.set_meta("name", "enemy")
	player = get_parent().find_child("player")

func _physics_process(_delta):
	super(_delta)
	nef_head_movement()
	#for i in get_slide_collision_count():
		#if  is_on_wall() :
			#$EnemyAnimationPlayer.play("Enemy_Turn_Right")
			# some how need enemy_speed to stop and kill the player
			#speed = 2
			#move_and_slide()
			#value += 1
			## refacter so that it is more dyamic and scalable 
			##ray.set_rotation_degrees(Vector3(0,0,90.237))
			#$laser_muzzle.set_rotation_degrees(Vector3(0,180,0))
		#if  is_on_wall() and value == 2:
			#$EnemyAnimationPlayer.play("Enemy_Turn_Left")
			#value = 0
			##ray.set_rotation_degrees(Vector3(0,0,-89.21))
			#$laser_muzzle.set_rotation_degrees(Vector3(0,0,0))

func nef_head_shoot_time():
	can_shoot = true

func _on_player_finding_player_seen():

	if player_finding_raycast.get_collider() == player:
		speed *= 0
		print("track player")
	if can_shoot:
		#var global_ray_direction = player_finding_raycast.to_global(player_finding_raycast.target_position).normalized()
		attack = laser_attack_scene.instantiate()
		attack.bullet_speed = 9
		#checks the speed if it postive or negative
		attack.is_left = speed > 0
		#attack.velocity = global_ray_direction
		get_parent().add_child(attack)
		attack.global_position = $laser_muzzle.global_position
		can_shoot = false
		timer.start()
		
func _on_player_finding_player_not_seen():
	can_shoot = false
	print("cant find player")
	speed = 0

func _on_AreaEnemy_area_entered(area):
	if (area.name == "ProjectileArea"):
		state_machine.travel("Enemy_Damage")
		damage_enemy(2)
		animation_player.play("Enemy_Damage")


func nef_head_movement():
	if not ground_finding_raycast.is_colliding():
		speed *= -1
		# rotation the sprite with the math of pi
		$EnemySprite.rotation.y += PI
		isFlipping = true


