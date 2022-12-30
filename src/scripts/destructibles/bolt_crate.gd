extends RigidBody

onready var bolt_instance = preload("res://scenes/Collectibles/bolt.tscn")

# For adding random numbers.
var random = RandomNumberGenerator.new()
var active=false
# Detects the collisions on this scene.
func _on_BoltCrate_body_entered(body):
	if body.name=="BlasterProjectileExplosion":
		queue_free()

# Detects the collisions on this scene.
func _on_Area_area_entered(body):
	if body.name == "ProjectileExplosionArea":
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
	queue_free()
