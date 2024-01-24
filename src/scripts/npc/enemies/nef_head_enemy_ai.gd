extends EnemyBase

@onready var laser_attack_scene = preload("res://scenes/Projectiles/nef_head_laser.tscn")
@onready var ray = $EnemySprite/player_finding

var value : int  = 0
var attack_delay : int = 2
var can_shoot : bool = true
var is_moving_left : bool = true
var target : Player = null
var attack = null
var timer = null

# Fix lock on redical.
func _ready():
	element = elements.AIR
	gravity = -4
	speed = -2
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
	# check to see if the collsion shape is on the floor of the level either through the EnemyBase
	# or the nef_enemy_ai script
	#this process is over writing the one in enemy base
	#this will run the base enemy function vs the one in the nef_head_enemy script
	super(_delta)
	#if is_on_floor():
		#print("true")
	#else:
		#print("false")
	for i in get_slide_collision_count():
		if  is_on_wall() :
			$EnemyAnimationPlayer.play("Enemy_Turn_Right")
			enemy_speed = 90
			move_and_slide()
			value += 1
			ray.set_rotation_degrees(Vector3(0,0,90.237))
			$laser_muzzle.set_rotation_degrees(Vector3(0,180,0))
		if  is_on_wall() and value == 2:
			$EnemyAnimationPlayer.play("Enemy_Turn_Left")
			value = 0
			ray.set_rotation_degrees(Vector3(0,0,-89.21))
			$laser_muzzle.set_rotation_degrees(Vector3(0,0,0))

func nef_head_shoot_time():
	can_shoot = true
#Refacter later
func _on_player_finding_player_seen():
	if can_shoot:
		attack = laser_attack_scene.instantiate()
		get_parent().add_child(attack)
		attack.global_position = $laser_muzzle.global_position
		attack.global_rotation = $laser_muzzle.global_rotation
		can_shoot = false
		timer.start()

func _on_AreaEnemy_area_entered(area):
	if (area.name == "ProjectileArea"):
		state_machine.travel("Enemy_Damage")
		damage_enemy(2)
		animation_player.play("Enemy_Damage")
