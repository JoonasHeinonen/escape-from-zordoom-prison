extends KinematicBody

# to do : add angela sprite
# to do : add rivet sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	#loads texture through code
	get_node("Sprite3D").set_texture(load("res://icon.png"))
	pass # Replace with function body.

