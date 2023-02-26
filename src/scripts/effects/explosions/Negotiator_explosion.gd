extends KinematicBody

func _ready():
	$"../KillTimer".connect("timeout", self, "_on_KillTimer_timeout")
	$"../KillTimer".start()
func _on_KillTimer_timeout():
	queue_free()

func debug_rotation_values(x, y, z):
	var values = "Rotation values: %s %s %s."	
	var args = values % [x, y, z]
	print(args)


