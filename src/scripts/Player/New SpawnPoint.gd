extends Area

# This updates the globle varable to change the postion of the player
func _on_New_SpawnPoint_body_entered(body):
	if body.name == "player":
		Globle.update_spawn(global_transform.origin)
		print(Globle.spawn_point)
