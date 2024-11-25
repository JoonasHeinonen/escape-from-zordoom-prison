extends EnemyBase

class_name BossBase

@onready var flame_projectile = preload("res://scenes/Projectiles/EnemyProjectiles/Flame.tscn")
@onready var explosion = preload("res://scenes/Effects/Explosions/ExplosiveCrateExplosion.tscn")
@onready var girdeux_body = preload("res://scenes/NPC/Enemies/Bosses/GirdeuxBody.tscn")

var is_damaged : bool = false
var is_player_nearby : bool = false
var is_dialog_ended : bool = false
var max_health : int = 0

var detect_distance_scale : Vector3
var detect_distance_dialog_scale : Vector3

func _ready():
	detect_distance_scale = $DetectDistance/CollisionShape3D.scale
	detect_distance_dialog_scale = detect_distance_scale * 1.25
	$DetectDistance/CollisionShape3D.scale = detect_distance_dialog_scale
	element = elements.GROUND

	match self.name:
		"Girdeux":
			enemy_health = 4
		_:
			enemy_health = 1
	max_health = enemy_health
	player = get_parent().get_parent().get_parent().get_node('player')

func _physics_process(_delta):
	if is_alerted and $AreaEnemy.cutscene_ended:
		$DetectDistance/CollisionShape3D.scale = detect_distance_scale
		if !is_in_range:
			# This goes up to three once the player starts moving
			is_dialog_ended = true
			$FlamethrowerTimer.start()
			$TurnTimer.start()

	if not is_on_floor():
		velocity.y = -4
		state_machine.travel("Enemy_Fall")
	else:
		if is_alerted:
			var health_data : float = (float(enemy_health) / float(max_health)) * 100
			player.boss_fight_active = true
			player.init_boss_fight(self.name, health_data, self.name.to_lower(), max_health)
			turn_enemy(player.position.x, self.position.x)
			if is_in_range and is_dialog_ended:
				state_machine.travel("Girdeux_Shoot")
		else:
			state_machine.travel("Enemy_Idle")

	# Do the jump logic after the boss is on wall.
	if (is_on_wall() and !is_player_nearby):
		velocity.y = 20
	set_velocity(velocity)
	set_up_direction(Vector3.UP)
	move_and_slide()
	
func turn_head():
	state_machine.travel("Girdeux_TurnHead")
	if (
		state_machine.get_current_node() == "Girdeux_TurnHead" and
		state_machine.get_current_play_position() == 1
	):
		state_machine.travel("Enemy_Walk")

func shoot_flames():
	var flame_instance = flame_projectile.instantiate()
	if (is_in_range):
		state_machine.travel("Girdeux_Shoot")
		flame_instance.position.x = 3
		get_parent().add_child(flame_instance)
		flame_instance.global_transform = $Flamethrower/FlamethrowerSprite/FlamethrowerPos.global_transform
		if direction == "Left": flame_instance.set_particle_size(-1)
		elif direction == "Right": flame_instance.set_particle_size(1)

func expire_enemy():
	player.boss_fight_active = false
	match self.name:
		"Girdeux":
			generate_body(girdeux_body.instantiate())
		_:
			pass
	queue_free()

func generate_body(body : Object):
	get_parent().add_child(body)
	body.global_transform = self.global_transform

func _on_FlamethrowerTimer_timeout():
	shoot_flames()

func _on_TurnTimer_timeout():
	decide_direction(direction)

func _on_DamageCooloffTimer_timeout():
	is_damaged = false

func _on_Weakspot_area_entered(area):
	if area.name == "ProjectileExplosionArea" and !is_damaged:
		var explosion_instance = explosion.instantiate()
		animation_player.play("Enemy_Damage")
		damage_enemy(1)
		is_damaged = true
		$DamageCooloffTimer.start()
		get_parent().add_child(explosion_instance)
		explosion_instance.scale = Vector3(3, 3, 3)
		explosion_instance.global_transform = self.global_transform

func _on_Weakspot_body_entered(_body):
	pass

func _on_AreaEnemy_body_entered(body):
	if (body.name == "player"):
		is_player_nearby = true

func _on_AreaEnemy_body_exited(body):
	if (body.name == "player"):
		is_player_nearby = false
