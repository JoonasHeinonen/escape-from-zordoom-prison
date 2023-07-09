extends KinematicBody

onready var radical 		  = preload("res://scenes/UI/GreenTargetRadical.tscn")

export(String, "Right", "Left") var direction
export var armored      : bool = false
export var enemy_health : int  = 10
export var enemy_speed  : int  = 10

var alerted   : bool 		  = false
var in_range  : bool 		  = false
var meta_name : String 		  = ""
var velocity  : Vector3 	  = Vector3(0, 0, 0)

var state_machine
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	meta_name = "enemy"
	state_machine = $EnemyAnimationTree.get("parameters/playback")
	self.set_meta("type", "enemy")
	self.set_meta("name", "enemy")

	player = get_parent().get_parent().get_parent().get_node('player')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Set the animation back to "Enemy_Idle".
	if (state_machine.get_current_node() == "Enemy_Damage"):
		if (state_machine.get_current_play_position() >= 0.2):
			state_machine.travel("Enemy_Idle")
	# Enemy expiration after the health is 0.
	if (enemy_health <= 0) : expire_enemy()

	# Determine the direction to take
	if direction == "Right" : $EnemySprite.flip_h = false
	elif direction == "Left": $EnemySprite.flip_h = true

func _physics_process(delta):
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

# Called when damage is dealt to the enemy.
func damage_enemy(health : int):
	enemy_health -= health

func turn_enemy(player_x : float, enemy_x : float):
	if (player_x > enemy_x):
		direction = "Right"
		self.scale.x = 1
		walk(3)
	elif (player_x < enemy_x):
		direction = "Left"
		self.scale.x = -1
		walk(-3)

# Called when enemy's health is 0.
func expire_enemy():
	queue_free()
	# TODO add enemy death animation.

# Adds an active radical.
func add_active_radical():
	var g_t_r = radical.instance()
	if (!self.has_node("res://scenes/UI/GreenTargetRadical.tscn")):
		self.add_child(g_t_r)

# Removes an active radical.
func remove_active_radical():
	var d_l = self.get_children()
	for c in d_l:
		if (c.name == "GreenTargetRadical"):
			c.queue_free()

# Walking functionality.
func walk(vel):
	if !in_range:
		state_machine.travel("Enemy_Walk")
		velocity.x = vel
	else:
		state_machine.travel("Enemy_Idle")
		velocity.x = 0

# When an area collides with this area.
# Used for a projectile collision now.
func _on_AreaEnemy_area_entered(area):
	if (area.name == "ProjectileExplosionArea"):
		alerted = true
		if (!armored):
			state_machine.travel("Enemy_Damage")
			damage_enemy(2)

# Act when the mouse has entered the base.
func _on_Enemy_mouse_entered():
	add_active_radical()

# Act when the mouse has left the base.
func _on_Enemy_mouse_exited():
	remove_active_radical()

# Act when the distance is adequate to the player.
func _on_DetectDistance_body_entered(body):
	if (body == player): print("Detection when entering: ", in_range)
	if (body == player && alerted):
		in_range = true

# Act when the distance is too far to the player.
func _on_DetectDistance_body_exited(body):
	if (body == player): print("Detection when exiting:  ", in_range)
	if (body == player && alerted):
		in_range = false
		turn_enemy(player.translation.x, self.translation.x)
