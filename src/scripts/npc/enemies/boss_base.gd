extends "res://src/scripts/npc/enemies/enemy_base.gd"

onready var flame_projectile = preload("res://scenes/Projectiles/enemy_projectiles/flame.tscn")

var damaged : bool 			 = false
var max_health : int 		 = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Determine the boss's health according to the name given.
	match self.name:
		"Girdeux":
			enemy_health = 4
		_:
			enemy_health = 1

	max_health = enemy_health
	player = get_parent().get_parent().get_parent().get_node('player')

func _physics_process(delta):
	if alerted && !in_range:
		$FlamethrowerTimer.start()
		$TurnTimer.start()
	if not is_on_floor():
		velocity.y = -4
		state_machine.travel("Enemy_Fall")
	else:
		# When the enemy character is aware of the player's vicinity.
		if alerted:
			var health_data : float = (float(enemy_health) / float(max_health)) * 100
			player.boss_fight_active = true
			player.init_boss_fight(self.name, health_data, self.name.to_lower(), max_health)
			turn_enemy(player.translation.x, self.translation.x)
		else:
			state_machine.travel("Enemy_Idle")
	move_and_slide(velocity, Vector3.UP)
	
func turn_head():
	state_machine.travel("Girdeux_TurnHead")
	if (
		state_machine.get_current_node() == "Girdeux_TurnHead" && 
		state_machine.get_current_play_position() == 1
	):
		state_machine.travel("Enemy_Walk")

func shoot_flames():
	var flame = flame_projectile.instance()
	flame.translation.x = 3
	get_parent().add_child(flame)
	flame.global_transform = $Flamethrower/FlamethrowerSprite/FlamethrowerPos.global_transform
	if direction == "Left": flame.set_particle_size(-1)
	elif direction == "Right": flame.set_particle_size(1)

# Called when boss's health is 0.
func expire_enemy():
	player.boss_fight_active = false
	queue_free()

func _on_FlamethrowerTimer_timeout():
	shoot_flames()

func _on_TurnTimer_timeout():
	decide_direction(direction)

func _on_DamageCooloffTimer_timeout():
	damaged = false

func _on_Weakspot_area_entered(area):
	if area.name == "ProjectileExplosionArea" && !damaged:
		state_machine.travel("Enemy_Damage")
		damage_enemy(1)
		damaged = true
		$DamageCooloffTimer.start()

func _on_Weakspot_body_entered(body):
	pass
