extends Area3D

@onready var health_light = preload("res://scenes/Effects/Player/CollectHealthNode.tscn")
@onready var trail_particle = preload("res://scenes/Effects/Collectibles/TrailParticles.tscn")

var projectile

@export_enum("bolt", "ammo", "nanotech_node") var type: String

var does_emit_trail : bool = false
var does_get_magnet : bool = false

var collectible_image_path : String = "res://resources/images/collectibles/"

# var position = Vector3()
var timer = Timer.new()
var random = RandomNumberGenerator.new()

func _ready():
	random.randomize()
	var bolt_index = str(random.randi_range(0,2))
	var bolt_file_name = "bolt_" + bolt_index + ".png"
	var resource = null

	if (self.has_node('TrailParticles')):
		projectile = $TrailParticles

	# Determine the type of the collectible.
	match (type):
		"bolt":
			match bolt_index:
				"0":
					resource = load(collectible_image_path + bolt_file_name)
					$Sprite3D.set_texture(resource)
				"1":
					resource = load(collectible_image_path + bolt_file_name)
					$Sprite3D.set_texture(resource)
				"2":
					resource = load(collectible_image_path + bolt_file_name)
					$Sprite3D.set_texture(resource)
		"ammo":
			resource = load(collectible_image_path + "ammo_can.png")
			$Sprite3D.set_texture(resource)

# Called during the physics processing step of the main loop.
func _physics_process(_delta):
	# Makes the bolts fall due to the y axis
#	if !does_get_magnet:
#		position.y

	if (does_emit_trail):
		$Particles.hide()
		$Particles2.hide()

	var bodies = get_overlapping_areas()
	for body in bodies:
		if body.name == "AreaPlayer":
			var player = body.get_parent()
			does_get_magnet = true
			if (type == "nanotech_node" and player.player_health < player.player_max_health):
					does_emit_trail = true
					for s in $Spots.get_children():
						var t_p = trail_particle.instantiate()
						t_p.global_transform = s.global_transform
						get_parent().add_child(t_p)
					queue_free()
			elif (type == "ammo"):
				for wpn in Globle.WPNS[3].size():
					if (Globle.WPNS[3][wpn] > Globle.player_weapons_ammo[wpn]):
						position += (get_parent().get_node("player").position - position) / 10
			else:
				if (get_parent().has_node("player")):
					position += (get_parent().get_node("player").position - position) / 10
				else:
					position += (get_parent().get_parent().get_node("player").position - position) / 10
		var sub_bodies = get_overlapping_bodies()
		for sub_body in sub_bodies:
			if sub_body.name == "player":
				# Plays the bolt sound on the player's instance.
				if sub_body.has_method("collect_collectible"):
					match(type):
						"bolt":
							random.randomize()
							var count_bolts
							if (get_parent().has_node("player")):
								count_bolts = get_parent().get_node("player").bolt + random.randi_range(5, 10)
							else:
								count_bolts = get_parent().get_parent().get_node("player").bolt + random.randi_range(5, 10)
							Globle.bolts += count_bolts
							sub_body.collect_collectible(random.randi_range(0, 2), "bolt")
							queue_free()

						"ammo":
							for wpn in Globle.WPNS[3].size():
								if (Globle.WPNS[3][wpn] > Globle.player_weapons_ammo[wpn] and Globle.current_weapons[wpn] == Globle.WPNS[0][wpn] and Globle.WPNS[3][wpn] > Globle.player_weapons_ammo[wpn]):
									var weapon_name : String = Globle.current_weapons[randi() % Globle.current_weapons.size()]
									if (weapon_name == "sheepinator") : weapon_name = Globle.current_weapons[randi() % Globle.current_weapons.size()]
									define_refillable_wpn(weapon_name, sub_body)

						"nanotech_node":
							if (sub_body.player_health < sub_body.player_max_health):
								var effects : Node = null
								var health_light_instance = health_light.instantiate()
								if (sub_body.has_node("Effects")):
									effects = sub_body.get_node("Effects")
									effects.add_child(health_light_instance)
								queue_free()

func define_refillable_wpn(weapon_name : String, body : CharacterBody3D):
	match(weapon_name):
		"edge_blaster":
			check_weapon_stats(weapon_name, 0, body, 16)
		"blitz_gun":
			check_weapon_stats(weapon_name, 1, body, 8)
		"gravity_bomb":
			check_weapon_stats(weapon_name, 2, body, 2)
		"negotiator":
			check_weapon_stats(weapon_name, 3, body, 1)
		"pulse_rifle":
			check_weapon_stats(weapon_name, 4, body, 2)
		"ry3no":
			check_weapon_stats(weapon_name, 5, body, 1)
		"sheepinator":
			pass
		"miniturret_glove":
			check_weapon_stats(weapon_name, 7, body, 3)

func check_weapon_stats(weapon_name : String, index : int, body : CharacterBody3D, ammo : int):
	var dynamic_ammo = ammo - ((Globle.player_weapons_ammo[index] + ammo) - Globle.WPNS[3][index])
	if (dynamic_ammo >= ammo) : dynamic_ammo = ammo
	if (Globle.player_weapons_ammo[index] > Globle.WPNS[3][index]):
		Globle.player_weapons_ammo[index] = Globle.WPNS[3][index]
	else:
		Globle.player_weapons_ammo[index] += dynamic_ammo
	body.ui_notification_msg(dynamic_ammo, weapon_name)
	body.collect_collectible(random.randi_range(0, 1), "ammo")
	queue_free()
