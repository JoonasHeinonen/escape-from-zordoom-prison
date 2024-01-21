extends Area3D

func _on_New_SpawnPoint_body_entered(body):
	if body.name == "player":
		Globle.update_spawn(global_transform.origin)
