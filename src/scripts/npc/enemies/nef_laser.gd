extends Area

var speed = -9

var velocity = Vector3(0,0,0)

func _physics_process(delta):
	velocity.x = speed * delta * 1
	translate(velocity)

func _on_KinematicBody_body_entered(body):
	if (body.name == "player"):
		body.damage_player(1)
	if !body.is_in_group("nef_head") :
		queue_free()
