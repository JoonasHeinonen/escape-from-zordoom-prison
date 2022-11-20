extends Node

signal items_changed(indexes)

var slots   = 8
var weapons = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(slots):
		weapons.append({})

func set_item(index, weapon):
	var previous_weapon = weapon
	weapons[index] = weapon
	emit_signal("items_changed", [index])
	return previous_weapon
