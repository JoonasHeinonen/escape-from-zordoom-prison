extends RigidBody

class_name ProjectileBase

var speed = 0

var velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	$KillTimer.connect("timeout", self, "_on_KillTimer_timeout")
	$KillTimer.start()

# Run when KillTimer has timed out.
func _on_KillTimer_timeout():
	queue_free()
