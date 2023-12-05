extends Area

onready var radical = preload("res://scenes/UI/GreenTargetRadical.tscn")

func _on_TargetDetectionArea_body_entered(body):
	if (body.has_meta("type")):
		if (
			body.get_meta("type") == "destroyable" and
			body.get_meta("type") == "enemy"
		):
			var g_t_r = radical.instance()
			var b_c = body.get_children()
			
			if (!body.has_node("GreenTargetRadical")):
				g_t_r = radical.instance()
				body.add_child(g_t_r)
			if (body.get_meta("type") == "destroyable"):
				g_t_r.global_transform = body.get_child(0).global_transform
				g_t_r.scale = Vector3(1, 1, 1)
			if (body.get_meta("type") == "enemy" and body.has_node("EnemySprite")):
				var e_s = body.get_node("EnemySprite")
				g_t_r.global_transform = e_s.global_transform
				g_t_r.scale = Vector3(1, 1, 1)

func _on_TargetDetectionArea_body_exited(body):
	if (body.has_meta("type")):
		if (
			body.get_meta("type") == "destroyable" and
			body.get_meta("type") == "enemy"
		):
			var l_c = body.get_children()
			for c in l_c:
				if (c.name == "GreenTargetRadical"):
					c.queue_free()
