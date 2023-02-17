extends Spatial

onready var countdown = $ExpireTimer.time_left

# Called when the node enters the scene tree for the first time.
func _ready():
	$ExpireTimer.connect("timeout", self, "_on_ExpireTimer_timeout")

# Timeout when the explosion fades out.
func _on_ExpireTimer_timeout():
	countdown -= 1
	if countdown <= 0:
		queue_free()
