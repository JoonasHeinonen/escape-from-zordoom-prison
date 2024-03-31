extends Node3D

@export var bullet_speed : float = 9.0
var velocity = Vector3(0,0,0)
var is_left :bool = true

func _physics_process(delta):
	# checks to see if the bullet is left or right and changes it to a directional value
	var direction = -1 if is_left else 1
	velocity.x = bullet_speed * delta * 1 * direction
	translate(velocity)

func _on_area_3d_body_entered(body):
	if (body.name == "player"):
		body.damage_player(1)
		print("enter body")
	if !body.is_in_group("nef_head") :
		queue_free()
