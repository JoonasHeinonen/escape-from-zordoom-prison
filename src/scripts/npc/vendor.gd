extends NPC

func _on_slim_cognito_body_entered(body):
	if body.name == "player":
		Globle.vendor_active = true
		active = true

func _on_slim_cognito_body_exited(body):
	if body.name == "player":
		Globle.vendor_active = false
		active = false
