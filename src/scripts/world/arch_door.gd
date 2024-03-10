extends Node3D

@onready var collision_shapes = [
	$DoorRight/StaticBody3D/CollisionShape3D,
	$DoorLeft/StaticBody3D/CollisionShape3D
]

var player

func _ready():
	player = get_parent().get_parent().get_node('player')

func swap_collision_shapes_values():
	for c_s in collision_shapes:
		c_s.disabled = !c_s.disabled

func _on_PlayerDetectionArea_body_entered(body):
	if (body.name == player.name && !player.boss_fight_active):
		swap_collision_shapes_values()
		self.hide()

func _on_PlayerDetectionArea_body_exited(body):
	if (body.name == player.name && !player.boss_fight_active):
		swap_collision_shapes_values()
		self.show()
