extends KinematicBody

func _physics_process(delta):
	self.rotation.x = 0
	self.rotation.y = 0
	self.rotation.z = 0
	debug_rotation_values(self.rotation.x, self.rotation.y, self.rotation.z)
	if $Sprite3D.frame in [4]:
		queue_free()

# Used to debug the rotation values.
func debug_rotation_values(x, y, z):
	var values = "Rotation values: %s %s %s."	
	var args = values % [x, y, z]
	print(args)
