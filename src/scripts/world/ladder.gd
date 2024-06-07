extends Node3D




func _on_static_body_3d_body_entered(body):
	if body.name == "player":
			print("enter ladder")


func _on_static_body_3d_body_exited(body):
		if body.name  == "player":
			print("exit ladder")
