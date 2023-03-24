extends "res://src/scripts/destructibles/destructible.gd"

# TODO Import the nanotech node once the scene for the node is done.

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
	print("Generating node") # TODO generates the nanotech node for player to collect.
