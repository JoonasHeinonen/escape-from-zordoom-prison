extends Area

var active = false
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"_on_slim_cognito_body_entered")
	connect("body_exited",self,"_on_slim_cognito_body_exited")

func _on_slim_cognito_body_entered(body):
	if body.name == "player":
		Globle.vendor_active = true
		active = true
		print("player has entered the vender body")
		
func _on_slim_cognito_body_exited(body):
	if body.name == "player":
		Globle.vendor_active = false
		active = false
		print("player has left the vender body")
		
func _process(delta):
	$EnterKey.visible = active
	pass
