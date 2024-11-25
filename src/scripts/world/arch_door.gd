extends Node3D

const ZERO_SIZE = Vector3(0.0, 0.0, 0.0)

@onready var collision_shapes = [
	$DoorRight/StaticBody3D/CollisionShape3D,
	$DoorLeft/StaticBody3D/CollisionShape3D
]

var original_collision_shapes_sizes = []
var player

func _ready():
	player = get_parent().get_parent().get_node('player')
	for c_s in collision_shapes:
		original_collision_shapes_sizes.append(c_s.scale)

func swap_collision_shapes_values(is_leaving : bool):
	for c_s in collision_shapes:
		if (is_leaving):
			c_s.scale = original_collision_shapes_sizes[0]
			self.show()
		else:
			c_s.scale = ZERO_SIZE
			self.hide()

func _on_PlayerDetectionArea_body_entered(body):
	if (body.name == player.name && !player.boss_fight_active):
		swap_collision_shapes_values(false)

func _on_PlayerDetectionArea_body_exited(body):
	if (body.name == player.name && !player.boss_fight_active):
		swap_collision_shapes_values(true)
