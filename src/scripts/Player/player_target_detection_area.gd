extends Area

onready var radical = preload("res://scenes/UI/GreenTargetRadical.tscn")

# When a body containing the proper tag enters the area.
func _on_TargetDetectionArea_body_entered(body):
	if (body.has_meta("type") &&
		body.get_meta("type") == "destroyable" ||
		body.get_meta("type") == "enemy"
	):
		var g_t_r
		var b_c   = body.get_children()
		
		for c in b_c:
			if (!c.has_node("res://scenes/UI/GreenTargetRadical.tscn")):
				g_t_r = radical.instance()
				body.add_child(g_t_r)
		# see if the boss will be affected by the targeting
		# have it so that it filters out what is a enemy or a destroyable
		#have it so that the mouse enters a enemy or a destroyable and the radical shows up
		if (body.get_meta("type") == "destroyable"):
			g_t_r.global_transform = body.get_child(0).global_transform
		if (body.get_meta("type") == "enemy"):
			g_t_r.global_transform = body.get_child(5).global_transform
		g_t_r.scale = Vector3(1,1,1)

# When a body containing the proper tag exits the area.
func _on_TargetDetectionArea_body_exited(body):
	if (body.has_meta("type") &&
		body.get_meta("type") == "destroyable" ||
		body.get_meta("type") == "enemy"
	):
		var l_c = body.get_children()
		for c in l_c:
			if (c.name == "GreenTargetRadical"):
				c.queue_free()
