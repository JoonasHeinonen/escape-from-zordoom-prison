extends Spatial

# Detects if a player has entered the detection area.
func _on_PlayerDetectionArea_body_entered(body):
	print(body)
	if (body.name == "player"):
		self.hide()

# Detects if a player has exited the detection area.
func _on_PlayerDetectionArea_body_exited(body):
	print(body)
	if (body.name == "player"):
		self.show()
