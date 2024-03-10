extends Area3D

@onready var radical = preload("res://scenes/UI/GreenTargetRadical.tscn")

# When a body containing the proper tag enters the area.
func _on_TargetDetectionArea_body_entered(body):
	if (body.has_meta("type") && body.get_meta("type") == "destroyable"):
		var g_t_r = radical.instantiate()
		var b_c   = body.get_children()
		
		for c in b_c:
			if (!c.has_node("res://scenes/UI/GreenTargetRadical.tscn")):
				body.add_child(g_t_r)
		g_t_r.global_transform = body.global_transform

# When a body containing the proper tag exits the area.
func _on_TargetDetectionArea_body_exited(body):
	if (body.has_meta("type") && body.get_meta("type") == "destroyable"):
		var l_c = body.get_children()
		for c in l_c:
			if (c.name == "GreenTargetRadical"):
				c.queue_free()
