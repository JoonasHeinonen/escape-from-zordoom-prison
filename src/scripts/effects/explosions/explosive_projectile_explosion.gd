extends CharacterBody3D

func _ready():
	$"../KillTimer".connect("timeout", Callable(self, "_on_KillTimer_timeout"))
	$"../KillTimer".start()

func _physics_process(delta):
	self.rotation.x = 0
	self.rotation.y = 0
	self.rotation.z = 0

# Used to debug the rotation values.
func debug_rotation_values(x, y, z):
	var values = "Rotation values: %s %s %s."	
	var args = values % [x, y, z]
	print(args)

func _on_KillTimer_timeout():
	queue_free()
