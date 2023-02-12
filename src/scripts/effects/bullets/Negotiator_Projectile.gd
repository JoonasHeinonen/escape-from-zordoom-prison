extends RigidBody

var speed = 8
var velocity = Vector3(0,0,0)


func _ready():
	pass

func _physics_process(delta):
	velocity.x = speed * delta * 1
	translate(velocity)



func _on_Area_body_entered(body):
	queue_free()
	pass 
