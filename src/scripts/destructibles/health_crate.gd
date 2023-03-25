extends "res://src/scripts/destructibles/destructible.gd"

onready var nanotech_node = preload("res://scenes/Collectibles/nanotech_node.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Detects the collisions on this scene.
func _on_Area_area_entered(body):
	if body.name == "ProjectileExplosionArea":
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
