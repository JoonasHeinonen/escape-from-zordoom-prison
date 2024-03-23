extends Node3D

class_name RowPattern

@onready var child_element = $ChildElement

@export var elems : int = 1
@export var distance : float = 0
@export var packed_scene : PackedScene

var dist : float = 0
var children = []

# Called when the node enters the scene tree for the first time.
func _ready():
	dist = distance
	for n in range(0, elems):
		var elem = packed_scene.instantiate()
		children.append(elem)
	for child in children:
		child.position.x = distance
		distance += dist
		add_child(child)
