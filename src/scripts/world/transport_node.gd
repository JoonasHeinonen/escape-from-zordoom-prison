extends Node3D

class_name TransportNode

var player
var player_in_activation_radius : bool = false

func _on_ActivationArea_body_entered(body):
	if body.name == "player":
		player_in_activation_radius = true
		player = body

func _on_ActivationArea_body_exited(body):
	if body.name == "player":
		player_in_activation_radius = false
		player = null
