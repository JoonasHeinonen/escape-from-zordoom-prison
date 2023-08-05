extends Area

onready var health_light = preload("res://scenes/Effects/Player/CollectHealthNode.tscn")
onready var trail_particle = preload("res://scenes/Effects/Collectibles/TrailParticles.tscn")
onready var projectile = $TrailParticles

export (String, "bolt", "ammo", "nanotech_node") var type

var active : bool = false
var getMagnet : bool = false
var emit_trail : bool = false
var get_magnet : bool = false

var collectible_image_path : String = "res://resources/images/collectibles/"

# var position = Vector3()
var timer = Timer.new()
var random = RandomNumberGenerator.new() # Adding random number.

# Called when the node enters the scene tree for the first time.
func _ready():
	random.randomize()
	var bolt_index = str(random.randi_range(0,2))
	var bolt_file_name = "bolt_" + bolt_index + ".png"
	var resource = null

	# Matches the type of the collectible.
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
	connect("body_exited" , self , "_on_Ammo_body_exited")
	connect("body_entered" , self , "_on_Ammo_body_entered")

# Called during the physics processing step of the main loop.
func _physics_process(delta):
	# Makes the bolts fall due to the y axis
	if !get_magnet:
		translation.y

	# Hide the particles for nanotech nodes.
	if (emit_trail):
		$Particles.hide()
		$Particles2.hide()

	var bodies = get_overlapping_areas()
	for body in bodies:
		if body.name == "AreaPlayer":
			var player = body.get_parent()
			get_magnet = true
			if (type == "nanotech_node"):
				if (player.player_health < player.player_max_health):
					emit_trail = true
					for s in $Spots.get_children():
						var t_p = trail_particle.instance()
						t_p.global_transform = s.global_transform
						get_parent().add_child(t_p)
					queue_free()
			elif (type == "ammo"):
				for wpn in Globle.WPNS[3].size():
					if (Globle.WPNS[3][wpn] > Globle.player_weapons_ammo[wpn]):
						translation += (get_parent().get_node("player").translation - translation) / 10
			else:
				translation += (get_parent().get_node("player").translation - translation) / 10
		var bodies2 = get_overlapping_bodies()
		for bod in bodies2:
			# This adds the bolt amount to the player.
			if bod.name == "player":
				# Makes sure that every number is random
				random.randomize()
				var count_boults = get_parent().get_node("player").bolt + random.randi_range(10, 100)
				# Grabes the bolt amout
				Globle.bolts += count_boults
				
				# Plays the bolt sound on the player's instance.
				if bod.has_method("collect_bolt"):
					match(type):
						"bolt":
							bod.collect_bolt(random.randi_range(0, 2), "bolt")
							queue_free()
						"ammo":
							for wpn in Globle.WPNS[3].size():
								if (Globle.WPNS[3][wpn] > Globle.player_weapons_ammo[wpn]):
									if (Globle.current_weapons[wpn] == Globle.WPNS[0][wpn]):
										if (Globle.WPNS[3][wpn] > Globle.player_weapons_ammo[wpn]):
											var wpn_name : String = Globle.current_weapons[randi() % Globle.current_weapons.size()]
											if (wpn_name == "sheepinator") : wpn_name = Globle.current_weapons[randi() % Globle.current_weapons.size()]
											var ammo : int = 0
											define_refillable_wpn(wpn_name, ammo, bod)
						"nanotech_node":
							if (bod.player_health < bod.player_max_health):
								var effects : Node = null
								var h_l = health_light.instance()
								if (bod.has_node("Effects")):
									effects = bod.get_node("Effects")
									effects.add_child(h_l)
								queue_free()

## Define the weapon to be refilled.
func define_refillable_wpn(wpn_name : String, ammo : int, body : KinematicBody):
	match(wpn_name):
		"edge_blaster":
			check_weapon_stats(0, 0, 16)
		"blitz_gun":
			check_weapon_stats(1, 1, 8)
		"gravity_bomb":
			check_weapon_stats(2, 2, 2)
		"negotiator":
			check_weapon_stats(3, 3, 1)
		"pulse_rifle":
			check_weapon_stats(4, 4, 2)
		"ry3no":
			check_weapon_stats(5, 5, 1)
		"sheepinator":
			pass
		"miniturret_glove":
			check_weapon_stats(7, 7, 3)
	body.ui_notification_msg(ammo, wpn_name)
	body.collect_bolt(random.randi_range(0, 1), "ammo")
	queue_free()

## Check the weapon statistics.
func check_weapon_stats(p_w_a_index : int, wpns_index : int, ammo : int):
	if (Globle.player_weapons_ammo[p_w_a_index] < Globle.WPNS[3][wpns_index]):
		if (Globle.player_weapons_ammo[p_w_a_index] < Globle.WPNS[3][wpns_index]):
			Globle.player_weapons_ammo[p_w_a_index] = Globle.WPNS[3][wpns_index]
		else:
			Globle.player_weapons_ammo[p_w_a_index] += ammo
