extends KinematicBody

func _physics_process(delta):
	if $Sprite3D.frame in [4]:
		queue_free()
