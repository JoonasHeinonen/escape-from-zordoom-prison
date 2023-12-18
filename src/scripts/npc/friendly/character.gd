extends CharacterBody3D

@export var direction # (String, "Right", "Left")

var player

func _ready():
	player = get_parent().get_parent().get_parent().get_node('player')

func _process(_delta):
	match (direction):
		"Right":
			$CharacterSprite.flip_h = false
		"Left":
			$CharacterSprite.flip_h = true

func _physics_process(_delta):
	turn_character(player.position.x, self.position.x)

func turn_character(player_x : float, character_x : float):
	if (player_x > character_x):
		direction = "Right"
	elif (player_x < character_x):
		direction = "Left"
