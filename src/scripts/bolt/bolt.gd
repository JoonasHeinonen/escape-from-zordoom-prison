extends Area

onready var health_light   = preload("res://scenes/Effects/Player/CollectHealthNode.tscn")
onready var trail_particle = preload("res://scenes/Effects/Collectibles/TrailParticles.tscn")
onready var projectile 	   = $TrailParticles

export (String, "bolt", "ammo", "nanotech_node") var type

var emit_trail 			   = false
var get_magnet 			   = false

# var position 			   = Vector3()
var timer 				   = Timer.new()

var active 				   = false
var getMagnet 			   = false

var random 	  			   = RandomNumberGenerator.new() # Adding random number.
var collectible_image_path = "res://resources/images/collectibles/"

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
	print(self.name)

	if (type == "bolt"):
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
	elif (type == "ammo"):
		resource = load(collectible_image_path + "ammo_can.png")
		$Sprite3D.set_texture(resource)

# Called during the physics processing step of the main loop.
func _physics_process(delta):
	if !get_magnet:
		# Makes the bolts fall due to the y axis
		translation.y

	if (emit_trail):
		$Particles.hide()
		$Particles2.hide()

	var bodies = get_overlapping_areas()
	for body in bodies:
		if body.name == "AreaPlayer":
			get_magnet = true
			if (type == "nanotech_node"):
				emit_trail = true
				for s in $Spots.get_children():
					var t_p = trail_particle.instance()
					t_p.global_transform = s.global_transform
					get_parent().add_child(t_p)
				queue_free()
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
						"ammo":
							bod.ui_notification_msg()
							bod.collect_bolt(random.randi_range(0, 1), "ammo")
						"nanotech_node":
							var effects : Node = null
							var h_l 		   = health_light.instance()
							if (bod.has_node("Effects")):
								effects = bod.get_node("Effects")
								effects.add_child(h_l)
				queue_free()
