extends KinematicBody

func _ready():
	$KillTimer.connect("timeout", self, "_on_KillTimer_timeout")
	$KillTimer.start()

# Run when KillTimer has timed out.
func _on_KillTimer_timeout():
	queue_free()
