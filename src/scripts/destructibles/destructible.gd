extends CharacterBody3D

class_name Destructible

@onready var bolt_instance = preload("res://scenes/Collectibles/bolt.tscn")
@onready var bolt_crate_fragments = preload("res://scenes/Destructibles/Crates/CrateFragments/BoltCrateFragments.tscn")
@onready var health_crate_fragments = preload("res://scenes/Destructibles/Crates/CrateFragments/HealthCrateFragments.tscn")
@onready var lamp_post_fragments = preload("res://scenes/Destructibles/Infrastructure/Lamps/LampFragments/LampPostFragments.tscn")
@onready var crate_destroy_effect = preload("res://scenes/Effects/Collectibles//CrateDestroyed.tscn")
@onready var radical = preload("res://scenes/UI/GreenTargetRadical.tscn")

@export_enum("bolt_crate", "lamp_post", "explosive_crate", "health_crate") var scene_type: String

var random = RandomNumberGenerator.new()
var destructible_velocity = Vector3(0, 0, 0)
var is_active : bool = false
var meta_type : String = ""
var meta_name : String = ""
var fragment_scene : PackedScene = null

func _ready():
	match (scene_type):
		"lamp_post":
			meta_type = "infra_destroyable"
			meta_name = "lamp post"
			fragment_scene = lamp_post_fragments
		"bolt_crate":
			meta_type = "destroyable" 
			meta_name = "bolt crate"
			fragment_scene = bolt_crate_fragments
		"explosive_crate":
			meta_type = "destroyable" 
			meta_name = "bolt crate"
		"health_crate":
			meta_type = "destroyable" 
			meta_name = "health crate"
			fragment_scene = health_crate_fragments
	self.set_meta("type", meta_type)
	self.set_meta("name", meta_name)

func _physics_process(_delta):
	destructible_velocity.y = -4
	set_velocity(destructible_velocity)
	set_up_direction(Vector3.UP)
	move_and_slide()

	if (self.has_node("Audio")):
		for audio_child in $Audio.get_children():
			audio_child.position = Vector3(self.position.x, self.position.y, 0)

func _process(_delta):
	if (
		scene_type != "explosive_crate" and 
		scene_type != "health_crate" and 
		Globle.melee_attack and is_active
	):
		createBolts()

func generate_bolt_position(x_axis, y_axis):
	var div = 0.3

	random.randomize()
	var x = random.randf_range(x_axis - div, x_axis + div)
	var y = random.randf_range(y_axis - div, y_axis + div)

	return Vector3(x, y, 0)

func take_damage(_amount : int) -> void:
	is_active = true
	
func no_damage(_amount : int) -> void:
	is_active = false
# TODO Also need to get the box to explode and to get bolts(?)

func createBolts():
	for i in 3:
		var bolt = bolt_instance.instantiate()
		get_parent().get_parent().get_parent().add_child(bolt)
		bolt.global_transform = global_transform
		bolt.scale = Vector3(1, 1, 1) # Resets bolt back to its actual size.
		bolt.transform.origin = generate_bolt_position(
			bolt.position[0],
			bolt.position[1]
		)
	create_fragments()
	destruction_effect()
	queue_free()

func destruction_effect():
	var destruction_effect_instance = null
	match (scene_type):
		"lamp_post":
			# d_e = lamp_post_destroy_effect.instantiate()
			# get_parent().get_parent().get_parent().add_child(d_e)
			# d_e.global_transform = global_transform
			pass
		"bolt_crate":
			destruction_effect_instance = crate_destroy_effect.instantiate()
			get_parent().get_parent().get_parent().add_child(destruction_effect_instance)
			destruction_effect_instance.global_transform = global_transform

func create_fragments():
	var fragment_scene_instance = fragment_scene.instantiate()
	get_parent().get_parent().get_parent().add_child(fragment_scene_instance)
	fragment_scene_instance.global_transform = global_transform

func add_active_radical():
	var green_target_radical = radical.instantiate()
	if (!self.has_node("res://scenes/UI/GreenTargetRadical.tscn")):
		self.add_child(green_target_radical)
		green_target_radical.scale = Vector3(1, 1, 1)

func remove_active_radical():
	var d_l = self.get_children()
	for c in d_l:
		if (c.name == "GreenTargetRadical"):
			c.queue_free()

func _on_BoltCrate_body_entered(body):
	if body.name == "BlasterProjectileExplosion" || body.name == "ExplosionEffectiveRadius":
		hide()

func _on_Area_area_entered(body):
	if body.name == "ProjectileExplosionArea" || body.name == "ExplosionEffectiveRadius":
		createBolts()

func _on_BoltCrate_mouse_entered():
	add_active_radical()

func _on_BoltCrate_mouse_exited():
	remove_active_radical()
