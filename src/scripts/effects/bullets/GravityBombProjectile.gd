extends RigidBody


var velocity = Vector3(1,-1,0)
#https://www.youtube.com/watch?v=p6OQ7XVsiKw

func _ready():
	$KillTimer.connect("timeout", self, "_on_KillTimer_timeout")
	$KillTimer.start()
	apply_impulse(Vector3.ZERO,velocity*10)

#https://www.youtube.com/watch?v=F1Fyj3Lh_Pc&t=239s
#Explosition effects
func _on_GravityBombArea_body_entered(body):
	queue_free()
	pass # Replace with function body.
