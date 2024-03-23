extends CharacterBody3D

var body_velocity  : Vector3 = Vector3(0, 0, 0)

func _physics_process(_delta):
	if not is_on_floor() : body_velocity.y = -4
	set_velocity(body_velocity)
	set_up_direction(Vector3.UP)
	move_and_slide()
