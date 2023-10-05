extends Area

onready var health_light = preload("res://scenes/Effects/Player/CollectHealthNode.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_transform.origin = lerp(global_transform.origin, get_parent().get_node("player").translation, delta * 3)

# When the nanotech particle hits the player.
func _on_TrailParticles_body_entered(body):
	if (body.name == "player"):
		var effects : Node = null
		var h_l = health_light.instance()
		if (body.has_node("Effects")):
			effects = body.get_node("Effects")
			effects.add_child(h_l)
			self.queue_free()
