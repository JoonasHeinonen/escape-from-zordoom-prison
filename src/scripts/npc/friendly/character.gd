extends CharacterBody3D

@export_enum("Right", "Left") var direction : String

var player

func _ready():
	player = get_tree().get_root().get_node("Level/player")

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
