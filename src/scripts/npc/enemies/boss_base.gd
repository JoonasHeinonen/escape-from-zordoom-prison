extends "res://src/scripts/npc/enemies/enemy_base.gd"

onready var flame_projectile = preload("res://scenes/Projectiles/enemy_projectiles/flame.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
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

func _on_FlamethrowerTimer_timeout():
	shoot_flames()

func _on_TurnTimer_timeout():
	decide_direction(direction)
