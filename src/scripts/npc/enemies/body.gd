extends KinematicBody

var velocity  : Vector3 = Vector3(0, 0, 0)

func _physics_process(delta):
	if not is_on_floor() : velocity.y = -4
	move_and_slide(velocity, Vector3.UP)
