extends CharacterBody3D

var velocity  : Vector3 = Vector3(0, 0, 0)

func _physics_process(delta):
	if not is_on_floor() : velocity.y = -4
	set_velocity(velocity)
	set_up_direction(Vector3.UP)
	move_and_slide()
