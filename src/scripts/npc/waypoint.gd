extends Node3D

var waypoint_active : bool = false

func _process(delta):
	if (waypoint_active):
		$PassiveWaypoint.hide()
		$ActiveWaypoint.show()
	else:
		$PassiveWaypoint.show()
		$ActiveWaypoint.hide()
