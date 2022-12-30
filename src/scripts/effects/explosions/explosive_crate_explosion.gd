extends Spatial

onready var countdown = $ExplosiveCrateExplosionTimer.time_left

# Called when the node enters the scene tree for the first time.
func _ready():
	$ExplosiveCrateExplosionTimer.connect("timeout", self, "_on_ExplosiveCrateExplosionTimer_timeout")

# Timeout when the explosion fades out.
func _on_ExplosiveCrateExplosionTimer_timeout():
	countdown -= 1
	if countdown <= 0:
		queue_free()
