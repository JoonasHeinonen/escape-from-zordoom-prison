extends Area3D

var active = false

func _on_slim_cognito_body_entered(body):
	if body.name == "player":
		Globle.vendor_active = true
		active = true

func _on_slim_cognito_body_exited(body):
	if body.name == "player":
		Globle.vendor_active = false
		active = false

func _process(delta):
	$EnterKey.visible = active
	pass
