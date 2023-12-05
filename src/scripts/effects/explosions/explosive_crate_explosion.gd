extends Spatial

onready var countdown = $ExpireTimer.time_left

func _on_ExpireTimer_timeout():
	countdown -= 1
	if countdown <= 0:
		queue_free()
