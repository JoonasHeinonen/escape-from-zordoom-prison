extends RigidBody


var velocity = Vector3(1,-1,0)
#https://www.youtube.com/watch?v=p6OQ7XVsiKw

func _ready():
	apply_impulse(Vector3.ZERO,velocity*10)
