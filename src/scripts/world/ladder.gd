extends Node3D
func _on_static_body_3d_body_entered(body):
	if body.name == "player":
			body.at_ladder = true

func _on_static_body_3d_body_exited(body):
		if body.name  == "player":
			body.at_ladder = false
