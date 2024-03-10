extends CharacterBody3D

func _ready():
	$KillTimer.connect("timeout", Callable(self, "_on_KillTimer_timeout"))
	$KillTimer.start()

func _on_KillTimer_timeout():
	queue_free()
