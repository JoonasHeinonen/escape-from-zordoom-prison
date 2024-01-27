extends EnemyBase

@onready var laser_attack_scene = preload("res://scenes/Projectiles/nef_head_laser.tscn")
@onready var player_finding_raycast = $EnemySprite/player_finding
@onready var ground_finding_raycast = $EnemySprite/ground_finding

var value : int  = 0
var attack_delay : int = 2
var can_shoot : bool = true
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
	speed = 0
	timer = Timer.new()
	timer.connect("timeout", Callable(self, "nef_head_shoot_time"))
	timer.wait_time = 1
	timer.one_shot = true
	add_child(timer)
	timer.start()
	meta_name = "nef_head"
	self.set_meta("type", "enemy")
	self.set_meta("name", "enemy")

func _physics_process(_delta):
	#this process is over writing the one in enemy base
	#this will run the base enemy function vs the one in the nef_head_enemy script
	super(_delta)
	speed = 2
	# checks to see if there is a no floor
	if not ground_finding_raycast.is_colliding():
		speed = 0
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
# maybe have a fucntion where the nef head is looking for the player.
#https://gamedevacademy.org/raycast3d-in-godot-complete-guide/#Adjusting_RayCast3D_Parameters
#how do you get the rotation of the z a raycast
func _on_player_finding_player_seen():
	#print("found player")
	speed = 1
	# it keeps moving 
	if can_shoot:
		attack = laser_attack_scene.instantiate()
		get_parent().add_child(attack)
		attack.global_position = $laser_muzzle.global_position
		attack.global_rotation = $laser_muzzle.global_rotation
		can_shoot = false
		timer.start()
		
func _on_player_finding_player_not_seen():
	can_shoot = false
	print("cant find player")
	speed = 0
	pass # Replace with function body.

func _on_AreaEnemy_area_entered(area):
	if (area.name == "ProjectileArea"):
		state_machine.travel("Enemy_Damage")
		damage_enemy(2)
		animation_player.play("Enemy_Damage")




