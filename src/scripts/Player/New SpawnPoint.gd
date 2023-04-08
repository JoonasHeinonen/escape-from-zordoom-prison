extends Area

# ToDo New spawn point
func _on_New_SpawnPoint_body_entered(body):
	Globle.update_spawn(global_transform.origin)
