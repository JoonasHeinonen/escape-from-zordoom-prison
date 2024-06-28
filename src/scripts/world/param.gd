extends Area3D

@onready var level = get_parent()
@export var index : int = 0

func _ready():
	print(level.mission_params.keys()[index], ": ", level.mission_params.values()[index])
	pass
