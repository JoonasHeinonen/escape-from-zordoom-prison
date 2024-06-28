extends Area3D

@onready var level = get_parent()
@export var index : int = 0

func _ready():
	print("Data coming from param.gd:")
	print(level.mission_params.values()[index])
	print("End data")
	pass
