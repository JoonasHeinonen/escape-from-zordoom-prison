extends KinematicBody

onready var bolt_instance 		 = preload("res://scenes/Collectibles/bolt.tscn")
onready var lamp_post_fragments  = preload("res://scenes/Destructibles/Infrastructure/Lamps/LampFragments/lamp_post_fragments.tscn")
onready var bolt_crate_fragments = preload("res://scenes/Destructibles/Crates/CrateFragments/bolt_crate_fragments.tscn")
onready var crate_destroy_effect = preload("res://scenes/Effects/Collectibles//CrateDestroyed.tscn")

export (String, "bolt_crate", "lamp_post") var scene_type

var random 						 = RandomNumberGenerator.new()
var velocity 			  		 = Vector3(0, 0, 0)
var active : bool 				 = false
var meta_type : String 			 = ""
var meta_name : String 			 = ""
var fragment_scene : PackedScene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	match (scene_type):
		"lamp_post":
			meta_type 	   = "infra_destroyable"
			meta_name 	   = "lamp post"
			fragment_scene = lamp_post_fragments
		"bolt_crate":
			meta_type 	   = "destroyable" 
			meta_name 	   = "bolt crate"
			fragment_scene = bolt_crate_fragments

	self.set_meta("type", meta_type)
	self.set_meta("name", meta_name)

func _physics_process(delta):
	velocity.y = -4
	move_and_slide(velocity, Vector3.UP)

# Detects the collisions on this scene.
func _on_BoltCrate_body_entered(body):
	if body.name == "BlasterProjectileExplosion" || body.name == "ExplosionEffectiveRadius":
		hide()

# Detects the collisions on this scene.
func _on_Area_area_entered(body):
	if body.name == "ProjectileExplosionArea" || body.name == "ExplosionEffectiveRadius":
		createBolts()

# Generates a random position for the bolt.
func generate_bolt_position(x_axis, y_axis):
	var div = 0.3

	random.randomize()
	var x = random.randf_range(x_axis - div, x_axis + div)
	var y = random.randf_range(y_axis - div, y_axis + div)
	
	return Vector3(x, y, 0)
	
func take_damage(amount:int)-> void:
	print("hit box has enterd the hurt box")
	active = true
	
func no_damage(amount:int)-> void:
	print("hit box has exit the hurt box")
	active = false
# Also need to get the box to explode and to get bolts

func _process(delta):
	if Globle.melee_attack && active:
		createBolts()

# Creates the default 3 bolts for the destroyed crate.
func createBolts():
	for i in 3:
		var bolt = bolt_instance.instance()
		get_parent().get_parent().get_parent().add_child(bolt)
		bolt.global_transform = global_transform
		bolt.scale = Vector3(1, 1, 1) # Resets bolt back to its actual size.
		bolt.transform.origin = generate_bolt_position(
			bolt.translation[0],
			bolt.translation[1]
		)
	var fragments = fragment_scene.instance()
	get_parent().get_parent().get_parent().add_child(fragments)
	fragments.global_transform = global_transform
	destruction_effect()
	queue_free()

# Emit the destruction effect.
func destruction_effect():
	var d_e = null
	# Matches the scene and the correct effect to that scene.
	match (scene_type):
		"lamp_post":
			# d_e = lamp_post_destroy_effect.instance()
			# get_parent().get_parent().get_parent().add_child(d_e)
			# d_e.global_transform = global_transform
			pass
		"bolt_crate":
			d_e = crate_destroy_effect.instance()
			get_parent().get_parent().get_parent().add_child(d_e)
			d_e.global_transform = global_transform
