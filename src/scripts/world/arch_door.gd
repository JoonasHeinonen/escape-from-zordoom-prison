extends Spatial

onready var collision_shapes = [
	$DoorRight/StaticBody/CollisionShape,
	$DoorLeft/StaticBody/CollisionShape
]

var player

func _ready():
	player = get_parent().get_parent().get_node('player')

# Detects if a player has entered the detection area.
func _on_PlayerDetectionArea_body_entered(body):
	if (body.name == player.name && !player.boss_fight_active):
		swap_collision_shapes_values()
		self.hide()

# Detects if a player has exited the detection area.
func _on_PlayerDetectionArea_body_exited(body):
	if (body.name == player.name && !player.boss_fight_active):
		swap_collision_shapes_values()

		self.show()

## Disable the door collision shapes.
func swap_collision_shapes_values():
	for c_s in collision_shapes:
		c_s.disabled = !c_s.disabled
