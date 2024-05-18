extends Node3D

@export var bullet_speed : float = 9.0
var velocity = Vector3(0,0,0)
@export var is_left :bool = false
@export var direction = 0
func _physics_process(delta):
	# checks to see if the bullet is left or right and changes it to a directional value
	#both directes are in the negative how can we get the different directions
	velocity.x = bullet_speed * delta * 1 * direction
	translate(velocity)
	#print(is_left)
	#print(velocity.x)

func _on_area_3d_body_entered(body):
	if (body.name == "player"):
		body.damage_player(1)
		#print("enter body")
	if !body.is_in_group("nef_head") :
		queue_free()
