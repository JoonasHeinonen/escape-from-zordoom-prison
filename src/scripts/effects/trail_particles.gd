extends Area3D

@onready var health_light = preload("res://scenes/Effects/Player/CollectHealthNode.tscn")

func _physics_process(delta):
	global_transform.origin = lerp(global_transform.origin, get_parent().get_node("player").position, delta * 3)

func _on_TrailParticles_body_entered(body):
	if (body.name == "player"):
		var effects : Node = null
		var h_l = health_light.instantiate()
		if (body.has_node("Effects")):
			effects = body.get_node("Effects")
			effects.add_child(h_l)
			self.queue_free()
