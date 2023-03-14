extends KinematicBody

export var enemy_health : int = 10
export var enemy_speed  : int = 10

var velocity 				  = Vector3(0, 0, 0)

var state_machine

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = $EnemyAnimationTree.get("parameters/playback")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(state_machine.get_current_node())
	velocity.y = -4
	move_and_slide(velocity, Vector3.UP)
	
	# Set the animation back to "Enemy_Idle".
	if (state_machine.get_current_node() == "Enemy_Damage"):
		if (state_machine.get_current_play_position() >= 0.2):
			state_machine.travel("Enemy_Idle")
	# Enemy expiration after the health is 0.
	if (enemy_health <= 0) : expire_enemy()

# Called when damage is dealt to the enemy.
func damage_enemy(health : int):
	print(state_machine.get_current_play_position())
	enemy_health -= health

# Called when enemy's health is 0.
func expire_enemy():
	queue_free()
	# TODO add enemy death animation.

# When an area collides with this area.
# Used for a projectile collision now.
func _on_AreaEnemy_area_entered(area):
	if (area.name == "ProjectileExplosionArea"):
		state_machine.travel("Enemy_Damage")
		damage_enemy(2)
