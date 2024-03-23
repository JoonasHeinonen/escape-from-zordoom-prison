extends CharacterBody3D

func _ready():
	$KillTimer.connect("timeout", Callable(self, "_on_KillTimer_timeout"))
	$KillTimer.start()

func _physics_process(_delta):
	self.rotation.x = 0
	self.rotation.y = 0
	self.rotation.z = 0

func _on_KillTimer_timeout():
	queue_free()
