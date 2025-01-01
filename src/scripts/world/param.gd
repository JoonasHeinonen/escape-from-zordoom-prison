extends Area3D

@onready var level = get_parent()
@export var index : int = 0

var player = null

func _ready():
	player = level.get_node("player")
	remove_param()

func _process(_delta):
	remove_param()

func remove_param():
	if (level.mission_params.values()[index]):
		queue_free()

func _on_body_entered(body):
	if (body.name == "player"):
		level.mission_params[level.mission_params.keys()[index]] = true
		player.set_missions()
