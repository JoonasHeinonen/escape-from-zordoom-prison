extends RigidBody

class_name ProjectileBase

var speed = 0

var velocity

func _ready():
	$KillTimer.connect("timeout", self, "_on_KillTimer_timeout")
	$KillTimer.start()

# Run when KillTimer has timed out.
func _on_KillTimer_timeout():
	queue_free()
