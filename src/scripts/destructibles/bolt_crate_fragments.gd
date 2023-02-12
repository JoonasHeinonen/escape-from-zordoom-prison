extends Spatial

onready var crate_destroy = $Audio/CrateDestroy

# Called when the node enters the scene tree for the first time.
func _ready():
	crate_destroy.play()
	$ExpireTimer.connect("timeout", self, "_on_ExpireTimer_timeout")
	$KillTimer.connect("timeout", self, "_on_KillTimer_timeout")
	$ExpireTimer.start()

# Crate fragments expiration.
func _on_ExpireTimer_timeout():
	queue_free()

# Used when the fadeout is in the place.
func _on_KillTimer_timeout():
	pass
