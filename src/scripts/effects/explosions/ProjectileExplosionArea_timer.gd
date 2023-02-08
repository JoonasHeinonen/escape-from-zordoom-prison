extends Area



func _ready():
	$"../KillTimer".connect("timeout", self, "_on_KillTimer_timeout")
	$"../KillTimer".start()
	pass


