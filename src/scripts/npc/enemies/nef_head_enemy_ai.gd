extends EnemyBase

@onready var laser_attack_scene = preload("res://scenes/Projectiles/nef_head_laser.tscn")
@onready var player_finding_raycast = $EnemySprite/player_finding
@onready var ground_finding_raycast = $EnemySprite/ground_finding
@onready var enemy_sprite = $EnemySprite
@onready var enemy_base = $EnemyBase
@onready var cooldown := $CoolDownTimer

var value : int  = 0
var attack_delay : int = 2
var can_shoot : bool = false
var is_flipping : bool = false
var is_moving_left : bool = true
var target : Player = null
var attack = null

func _ready():
	element = elements.AIR
	gravity = -4
	#timer = Timer.new()
	#timer.connect("timeout", Callable(self, "nef_head_shoot_time"))
	#timer.wait_time = 1
	#timer.one_shot = true
	#add_child(timer)
	#timer.start()
	
	meta_name = "nef_head"
	self.set_meta("type", "enemy")
	self.set_meta("name", "enemy")
	player = get_parent().get_parent().get_parent().get_node('player')

func _physics_process(_delta):
	#allows the EnemyBase _physics_process function works
	#in the nef_head_enemy_ai script
	# how can we make the enemy movement speed work from here?
	super(_delta)
	nef_head_movement()
	_on_player_finding_player_seen()

#may need some changes
func _on_player_finding_player_seen():
	if player_finding_raycast.get_collider() != player:
		can_shoot = false
	if player_finding_raycast.get_collider() == player:
		can_shoot = true
		
		print(cooldown)
	if can_shoot == true and cooldown.is_stopped():
		var player_direction = (player.global_position.x - global_position.x)
		#print(player_direction)
		attack = laser_attack_scene.instantiate()
		attack.bullet_speed = 9
		#This checks the speed if it postive or negative.
		attack.is_left = speed > 0
		get_parent().add_child(attack)
		attack.global_position = $laser_muzzle.global_position
		can_shoot = false
		attack.direction = 1
		if player_direction < 0:
			attack.direction = -1
		if player_direction >0:
			attack.direction = 1
		cooldown.start()
		#timer.stop()
		
		
		
func _on_player_finding_player_not_seen():
	pass

func _on_AreaEnemy_area_entered(area):
	if (area.name == "ProjectileArea"):
		state_machine.travel("Enemy_Damage")
		damage_enemy(2)
		animation_player.play("Enemy_Damage")
# $EnemySprite.rotation.y += PI will use rotation by the y axis the sprite with the math of pi
func nef_head_movement():
	#looks for a wall or a box and then it flips the nef head sprite
	#print(self.enemy_speed)
	#need to refactor
	is_flipping = false
	if is_on_wall() == true:
		# print("hits wall")
		enemy_sprite.rotation.y += PI
		self.enemy_speed *= -1
		print(enemy_speed)
		is_flipping = true
	if not ground_finding_raycast.is_colliding():
		self.enemy_speed *= -1
		enemy_sprite.rotation.y += PI
		is_flipping = true
		print(enemy_speed)
