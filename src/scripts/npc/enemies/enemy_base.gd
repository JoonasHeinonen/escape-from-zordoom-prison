extends CharacterBody3D

class_name EnemyBase

@onready var radical = preload("res://scenes/UI/GreenTargetRadical.tscn")

enum elements {GROUND, WATER, AIR, STATIC}

@export_enum("Right", "Left") var direction: String
@export_enum("Patrol", "Idle", "Aggressive") var stances: String

@export var is_armored : bool = false
@export var enemy_health : int = 10
@export var enemy_speed : int = 0

var is_alerted : bool = false
var is_dead : bool = false
var is_in_range : bool = false

var element = null
var stance = null
var meta_name : String = ""
var speed : int
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var animation_player = $EnemyAnimationPlayer
var player
@onready var state_machine = $EnemyAnimationTree.get("parameters/playback")

func _ready():
	element = elements.STATIC
	meta_name = "enemy"
	self.set_meta("type", "enemy")
	self.set_meta("name", "enemy")
	player = get_parent().get_parent().get_parent().get_node('player')

func _process(_delta):
	if (state_machine.get_current_node() == "Enemy_Damage" and state_machine.get_current_play_position() >= 0.2):
		state_machine.travel("Enemy_Idle")
	if (enemy_health <= 0) : expire_enemy()

func _physics_process(delta):
	determine_element(element, delta)

	if (self.has_node("Audio")):
		for audio_child in $Audio.get_children():
			audio_child.position = Vector3(self.position.x, self.position.y, 0)

func determine_element(element, delta: float):
	match (element):
		elements.GROUND:
			if not is_on_floor():
				velocity.y -= gravity * delta
			set_velocity(velocity)
			set_up_direction(Vector3.UP)
			move_and_slide()
		elements.STATIC:
			if not is_on_floor():
				velocity.y -= gravity * delta
			set_velocity(velocity)
			set_up_direction(Vector3.UP)
			move_and_slide()
		elements.AIR:
			velocity.y = gravity
			velocity.x = speed * 1
			set_velocity(velocity * delta)
			move_and_slide()

## TODO Develop the stances later on.
func determine_stance(stance: String, vel: float):
	match(stance):
		"Patrol":
			if (is_on_wall()):
				if (direction == "Left"):
					$EnemySprite.scale.x = -4
					velocity.x = vel
					direction = "Right"
				elif (direction == "Right"):
					$EnemySprite.scale.x = 4
					velocity.x -= vel
					direction = "Left"
		"Idle":
			pass
		"Aggressive":
			pass
		_:
			pass

func damage_enemy(health : int):
	if (element == elements.STATIC):
		if (player.position.x > self.position.x):
			decide_direction("Left")
		elif (player.position.x < self.position.x):
			decide_direction("Right")
	enemy_health -= health

func decide_direction(d : String):
	if d == "Right" : 
		$EnemySprite.flip_h = false
		self.scale.x = 1
	elif d == "Left": 
		$EnemySprite.flip_h = true
		self.scale.x = -1

func turn_enemy(player_x : float, enemy_x : float):
	if (player_x > enemy_x):
		direction = "Right"
		walk(3)
	elif (player_x < enemy_x):
		direction = "Left"
		walk(-3)

func expire_enemy():
	is_dead = true
	get_tree().call_group("arena_menu_group", "check_current_enemies")
	queue_free()
	# TODO add enemy death animation.

func add_active_radical():
	var g_t_r = radical.instantiate()
	if (!self.has_node("res://scenes/UI/GreenTargetRadical.tscn")):
		self.add_child(g_t_r)
		g_t_r.global_transform = $EnemySprite.global_transform
		g_t_r.scale = Vector3(1, 1, 1)

func remove_active_radical():
	var d_l = self.get_children()
	for c in d_l:
		if (c.name == "GreenTargetRadical"):
			c.queue_free()

func walk(vel):
	if !is_in_range:
		state_machine.travel("Enemy_Walk")
		velocity.x = vel
	else:
		state_machine.travel("Enemy_Idle")
		velocity.x = 0

func _on_AreaEnemy_area_entered(area):
	if (area.name == "ProjectileExplosionArea"):
		is_alerted = true
		if (!is_armored):
			state_machine.travel("Enemy_Damage")
			damage_enemy(2)

func _on_Enemy_mouse_entered():
	add_active_radical()

func _on_Enemy_mouse_exited():
	remove_active_radical()

func _on_DetectDistance_body_entered(body):
	if (body == player && is_alerted):
		is_in_range = true

func _on_DetectDistance_body_exited(body):
	if (body == player && is_alerted):
		is_in_range = false
