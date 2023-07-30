extends KinematicBody

onready var radical = preload("res://scenes/UI/GreenTargetRadical.tscn")

enum elements {GROUND, WATER, AIR}

export var enemy_health : int = 10
export var enemy_speed : int = 10

var gravity : int
var direction : int
var speed : int
var meta_name : String = ""
var velocity = Vector3(0, 0, 0)
var element = null

var state_machine

# Called when the node enters the scene tree for the first time.
func _ready():
	element = elements.GROUND
	meta_name = "enemy"
	state_machine = $EnemyAnimationTree.get("parameters/playback")
	self.set_meta("type", "enemy")
	self.set_meta("name", "enemy")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Set the animation back to "Enemy_Idle".
	if (state_machine.get_current_node() == "Enemy_Damage"):
		if (state_machine.get_current_play_position() >= 0.2):
			state_machine.travel("Enemy_Idle")
	# Enemy expiration after the health is 0.
	if (enemy_health <= 0) : expire_enemy()

# Called every frame.
func _physics_process(delta):
	match (element):
		elements.GROUND:
			velocity.y = -4
			move_and_slide(velocity, Vector3.UP)
		elements.AIR:
			velocity.y = gravity
			velocity.x = speed * direction
			move_and_slide(velocity * delta)

# Called when damage is dealt to the enemy.
func damage_enemy(health : int):
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

# Adds an active radical.
func add_active_radical():
	var g_t_r = radical.instance()
	if (!self.has_node("res://scenes/UI/GreenTargetRadical.tscn")):
		self.add_child(g_t_r)
		g_t_r.global_transform = $EnemySprite.global_transform
		g_t_r.scale = Vector3(1, 1, 1)

# Removes an active radical.
func remove_active_radical():
	var d_l = self.get_children()
	for c in d_l:
		if (c.name == "GreenTargetRadical"):
			c.queue_free()

# Act when the mouse has entered the base.
func _on_Enemy_mouse_entered():
	add_active_radical()

# Act when the mouse has left the base.
func _on_Enemy_mouse_exited():
	remove_active_radical()
