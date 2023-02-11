extends Area



func _ready():
	$"../KillTimer".connect("timeout", self, "_on_KillTimer_timeout")
	$"../KillTimer".start()
	pass


func _on_KillTimer_timeout():
	queue_free()
