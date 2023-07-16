extends KinematicBody


var motion = Vector3()

var gravity = 0

var direction = 1

var is_moving_left = true

var speed = -90

var target: Player = null

var value  = 0

onready var ray =$Sprite3D/player_finding

var laser_attack_scene = preload("res://scenes/Projectiles/nef_head_laser.tscn")

onready var radical = preload("res://scenes/UI/GreenTargetRadical.tscn")

var attack = null

var attack_delay = 2

var timer = null

var can_shoot = true

var state_machine

export var enemy_health : int = 10

var meta_name : String 		  = ""

onready var animation_Player  = $AnimationPlayer

#timer that has it so that it only shoots one bullet at a time after the player in in range

# fix lock on redical 
func _ready():
	timer = Timer.new()
	timer.connect("timeout", self, "nef_head_shoot_time")
	timer.wait_time = 1
	timer.one_shot = true
	add_child(timer)
	timer.start()
	meta_name = "nef_head"
	state_machine = $AnimationTree.get("parameters/playback")
	self.set_meta("type", "enemy")
	self.set_meta("name", "enemy")

	
func _process(_delta):
	# Enemy expiration after the health is 0.
	
	if (state_machine.get_current_node() == "Enemy_Damage"):
		if (state_machine.get_current_play_position() >= 0.2):
			state_machine.travel("Enemy_Idle")
	if (enemy_health <= 0) : expire_enemy()
	
	
func _physics_process(delta):
	motion.y = gravity
	
	motion.x = speed * direction
	move_and_slide(motion * delta)
	# changes direction 
	for i in get_slide_count():
		var slide_collision = get_slide_collision(i)
		var collider = slide_collision.get_collider()
		if  is_on_wall() :
			$AnimationPlayer.play("Enemy_Turn_Right")
			speed *= -1
			value += 1
			ray.set_rotation_degrees(Vector3(0,0,90.237))
			$laser_muzzle.set_rotation_degrees(Vector3(0,180,0))
		if  is_on_wall() and value == 2:
			$AnimationPlayer.play("Enemy_Turn_Left")
			value = 0
			ray.set_rotation_degrees(Vector3(0,0,-89.21))
			$laser_muzzle.set_rotation_degrees(Vector3(0,0,0))
	

func nef_head_shoot_time():
	can_shoot = true

	
func _on_player_finding_player_seen():
	# has it so that the projectile only shoots once every few secs
	if  can_shoot:
		attack = laser_attack_scene.instance()
		get_parent().add_child(attack)
		attack.global_translation = $laser_muzzle.global_translation
		attack.global_rotation = $laser_muzzle.global_rotation
		can_shoot = false
		timer.start()

# Adds an active radical.
func add_active_radical():
	if (!self.has_node("GreenTargetRadical")):
		var g_t_r = radical.instance()
		self.add_child(g_t_r)
		var right_scale = 1 / scale.x
		g_t_r.scale = Vector3(right_scale,right_scale,right_scale)
		print(self.has_node("target_radical"))
		if self.has_node("target_radical"):
			g_t_r.transform = $target_radical.transform
			
			
# Removes an active radical.
func remove_active_radical():
	if (self.has_node("GreenTargetRadical")):
		$GreenTargetRadical.queue_free()
	var d_l = self.get_children()
	for c in d_l:
		if (c.name == "GreenTargetRadical"):
			c.queue_free()
# Act when the mouse has entered the base.
func _on_nef_head_mouse_entered():
	add_active_radical()

func _on_nef_head_mouse_exited():
	remove_active_radical()
# Called when enemy's health is 0.
func expire_enemy():
	queue_free()

# Called when damage is dealt to the enemy.
func damage_enemy(health : int):
	enemy_health -= health

func _on_AreaEnemy_area_entered(area):
	if (area.name == "ProjectileExplosionArea"):
		state_machine.travel("Enemy_Damage")
		damage_enemy(2)
		animation_Player.play("Enemy_Damage")
