extends EnemyBase

onready var laser_attack_scene = preload("res://scenes/Projectiles/nef_head_laser.tscn")
onready var ray = $EnemySprite/player_finding

var value : int  = 0
var attack_delay : int = 2
var can_shoot : bool = true
var is_moving_left : bool = true
var target : Player = null
var attack = null
var timer = null

# Timer that has it so that it only shoots one bullet at a time after the player in in range.

# Fix lock on redical.
func _ready():
	element = elements.AIR
	gravity = 0
	speed = -90
	timer = Timer.new()
	timer.connect("timeout", self, "nef_head_shoot_time")
	timer.wait_time = 1
	timer.one_shot = true
	add_child(timer)
	timer.start()
	meta_name = "nef_head"
	self.set_meta("type", "enemy")
	self.set_meta("name", "enemy")

func _physics_process(_delta):
	for i in get_slide_count():
		if  is_on_wall() :
			$EnemyAnimationPlayer.play("Enemy_Turn_Right")
			speed *= -1
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

func _on_player_finding_player_seen():
	if can_shoot:
		attack = laser_attack_scene.instance()
		get_parent().add_child(attack)
		attack.global_translation = $laser_muzzle.global_translation
		attack.global_rotation = $laser_muzzle.global_rotation
		can_shoot = false
		timer.start()

func _on_AreaEnemy_area_entered(area):
	if (area.name == "ProjectileExplosionArea"):
		state_machine.travel("Enemy_Damage")
		damage_enemy(2)
		animation_player.play("Enemy_Damage")
