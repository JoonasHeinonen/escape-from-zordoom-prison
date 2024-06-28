extends Area3D

@onready var level = get_parent()
@export var index : int = 0

func _ready():
	remove_param()

func _process(_delta):
	remove_param()

func remove_param():
	if (level.mission_params.values()[index]):
		queue_free()

func _on_body_entered(body):
	if (body.name == "player"):
		level.mission_params[level.mission_params.keys()[index]] = true
