extends Area

onready var radical = preload("res://scenes/UI/GreenTargetRadical.tscn")

# When a body containing the proper tag enters the area.
func _on_TargetDetectionArea_body_entered(body):
	if (body.has_meta("type")):
		if (
			body.get_meta("type") == "destroyable" ||
			body.get_meta("type") == "enemy"
		):
			var g_t_r = radical.instance()
			var b_c = body.get_children()
			
			if (!body.has_node("GreenTargetRadical")):
				g_t_r = radical.instance()
				body.add_child(g_t_r)
			# see if the boss will be affected by the targeting
			if (body.get_meta("type") == "destroyable"):
				g_t_r.global_transform = body.get_child(0).global_transform
				g_t_r.scale = Vector3(1, 1, 1)
			if (body.get_meta("type") == "enemy"):
				if body.has_node("EnemySprite"):
					var e_s = body.get_node("EnemySprite")
					g_t_r.global_transform = e_s.global_transform
					g_t_r.scale = Vector3(1, 1, 1)

# When a body containing the proper tag exits the area.
func _on_TargetDetectionArea_body_exited(body):
	if (body.has_meta("type")):
		if (
			body.get_meta("type") == "destroyable" ||
			body.get_meta("type") == "enemy"
		):
			var l_c = body.get_children()
			for c in l_c:
				if (c.name == "GreenTargetRadical"):
					c.queue_free()
