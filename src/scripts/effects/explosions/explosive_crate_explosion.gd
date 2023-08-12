extends Spatial

onready var countdown = $ExpireTimer.time_left

# Timeout when the explosion fades out.
func _on_ExpireTimer_timeout():
	countdown -= 1
	if countdown <= 0:
		queue_free()
