extends CharacterBody3D

func _physics_process(_delta):
	self.rotation.x = 0
	self.rotation.y = 0
	self.rotation.z = 0
	if $Sprite3D.frame in [4]:
		queue_free()

func debug_rotation_values(x, y, z):
	var values = "Rotation values: %s %s %s."	
	var args = values % [x, y, z]
	print(args)
