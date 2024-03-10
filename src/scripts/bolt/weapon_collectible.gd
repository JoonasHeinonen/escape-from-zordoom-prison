extends Area3D

@onready var sprite = $Sprite3D
@onready var player = get_parent().get_parent().get_node("player")

@export(String, "edge_blaster", "blitz_gun", "gravity_bomb", "negotiator",
	"pulse_rifle", "ry3no", "sheepinator") var weapon

var get_magnet = false
var weapon_name
var random = RandomNumberGenerator.new()

func _ready():
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
	if !get_magnet:
		# Makes the bolts fall due to the y axis.
		position.y

	var bodies = get_overlapping_areas()
	for body in bodies:
		if body.name == "AreaPlayer":
			get_magnet = true
			position += (player.position-position) / 5
		var bodies2 = get_overlapping_bodies()
		for bod in bodies2:
			# Adds the item to the player's inventory.
			if bod.name == "player":
				var wpn_index : int = -1
				for wpn_for_sale in Globle.weapons_for_sale:
					wpn_index += 1
					if wpn_for_sale == weapon:
						Globle.weapons_for_sale.remove(wpn_index)
				Globle.current_weapons.append(weapon)
				if (player.current_weapon == null):
					player.current_weapon = weapon
					player.change_weapon_texture(weapon)
				queue_free()

func set_weapon_image(wpn_name: String):
	var weapon_sprite_path = "res://resources/images/weapons/" + wpn_name + ".png"
	sprite.texture = load(weapon_sprite_path)
