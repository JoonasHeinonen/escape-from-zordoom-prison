extends Area

onready var sprite  = $Sprite3D
onready var player  = $Player

export(String, "edge_blaster", "blitz_gun", "gravity_bomb", "negotiator",
	"pulse_rifle", "ry3no", "sheepinator") var weapon

var getMagnet 	  	= false

var weapon_name

# Adding a random number.
var random 	  = RandomNumberGenerator.new()

func _ready():
	# Destroy the object, if the item already exists in the inventory.
	for i in Globle.current_weapons:
		if (i == weapon):
			queue_free()
	if (weapon == null):
		weapon = Globle.WEAPONS[randi() % 7 + 1]
	match weapon:
		"edge_blaster":
			set_weapon_image("edge_blaster")
		"blitz_gun":
			set_weapon_image("blitz_gun")
		"gravity_bomb":
			set_weapon_image("gravity_bomb")
		"negotiator":
			set_weapon_image("negotiator")
		"pulse_rifle":
			set_weapon_image("pulse_rifle")
		"ry3no":
			set_weapon_image("ry3no")
		"sheepinator":
			set_weapon_image("sheepinator")

func _physics_process(delta):
	var x : int = 0
	if !getMagnet:
		# Makes the bolts fall due to the y axis.
		translation.y

	var bodies = get_overlapping_areas()
	for body in bodies:
		if body.name == "AreaPlayer":
			getMagnet = true
			translation += (get_parent().get_node("player").translation-translation) / 5
		var bodies2 = get_overlapping_bodies()
		for bod in bodies2:
			# Adds the item to the player's inventory.
			if bod.name=="player":
				Globle.current_weapons.append(weapon)
				Globle.update_vendor()
				queue_free()

# Changes the texture of the gun.
func set_weapon_image(weapon_name: String):
	var weapon_sprite_path = "res://resources/images/weapons/" + weapon_name + ".png"
	sprite.texture = load(weapon_sprite_path)
