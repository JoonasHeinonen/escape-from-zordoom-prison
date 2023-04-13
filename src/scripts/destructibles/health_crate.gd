extends "res://src/scripts/destructibles/destructible.gd"

onready var nanotech_node = preload("res://scenes/Collectibles/nanotech_node.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globle.melee_attack && active:
		generate_health_node()
		queue_free()

# Detects the collisions on this scene.
func _on_Area_area_entered(body):
	if body.name == "ProjectileExplosionArea" || body.name == "ExplosionEffectiveRadius":
		generate_health_node()
		queue_free()

# Generates the nanotech node for player to collect
func generate_health_node():
	# TODO Generate the health crate splinters.
	create_fragments()
	var n_n = nanotech_node.instance()
	get_parent().get_parent().get_parent().add_child(n_n)
	n_n.global_transform = global_transform
	queue_free()
