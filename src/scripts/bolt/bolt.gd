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
						pass # translation += (get_parent().get_node("player").translation - translation) / 10
			else:
				translation += (get_parent().get_node("player").translation - translation) / 10
		var bodies2 = get_overlapping_bodies()
		for bod in bodies2:
			# This adds the bolt amount to the player.
			if bod.name == "player":
				# Makes sure that every number is random
				random.randomize()
				var countBoults = get_parent().get_node("player").bolt + random.randi_range(10, 100)
				# Grabes the bolt amout
				Globle.bolts += countBoults
				
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
											randomize()
											var wpn_name : String = Globle.current_weapons[randi() % Globle.current_weapons.size()]
											var ammo : int = 0
											match(wpn_name):
												"edge_blaster":
													if (Globle.player_weapons_ammo[0] < Globle.WPNS[3][0]):
														ammo = 16
														Globle.player_weapons_ammo[0] += ammo
												"blitz_gun":
													if (Globle.player_weapons_ammo[1] < Globle.WPNS[3][1]):
														ammo = 8
														Globle.player_weapons_ammo[1] += ammo
												"gravity_bomb":
													if (Globle.player_weapons_ammo[2] < Globle.WPNS[3][2]):
														ammo = 2
														Globle.player_weapons_ammo[2] += ammo
												"negotiator":
													if (Globle.player_weapons_ammo[3] < Globle.WPNS[3][3]):
														ammo = 1
														Globle.player_weapons_ammo[3] += ammo
												"pulse_rifle":
													if (Globle.player_weapons_ammo[4] < Globle.WPNS[3][4]):
														ammo = 2
														Globle.player_weapons_ammo[4] += ammo
												"ry3no":
													if (Globle.player_weapons_ammo[5] < Globle.WPNS[3][5]):
														ammo = 1
														Globle.player_weapons_ammo[5] += ammo
												"sheepinator":
													ammo = 0
													Globle.player_weapons_ammo[6] += ammo
												"miniturret_glove":
													if (Globle.player_weapons_ammo[7] < Globle.WPNS[3][7]):
														ammo = 3
														Globle.player_weapons_ammo[7] += ammo
											bod.ui_notification_msg(ammo, wpn_name)
											bod.collect_bolt(random.randi_range(0, 1), "ammo")
											queue_free()
						"nanotech_node":
							if (bod.player_health < bod.player_max_health):
								var effects : Node = null
								var h_l = health_light.instance()
								if (bod.has_node("Effects")):
									effects = bod.get_node("Effects")
									effects.add_child(h_l)
								queue_free()
