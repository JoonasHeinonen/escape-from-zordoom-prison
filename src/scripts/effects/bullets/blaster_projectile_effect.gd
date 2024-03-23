extends CharacterBody3D

var speed = -1
var projectile_velocity = Vector3(0,0,0)

func _physics_process(delta):
	projectile_velocity.x = speed * delta * 1
	translate(projectile_velocity)
	if $Sprite3D.frame in [0]:
		queue_free()
