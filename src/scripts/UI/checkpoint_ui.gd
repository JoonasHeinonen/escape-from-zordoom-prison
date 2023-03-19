extends Area
var active=false
func _ready():
	connect("body_entered",self,"_on_checkpoint_body_entered")
	connect("body_exited",self,"_on_checkpoint_body_exited")
	pass 
	#adds so when the player enters the collisionshape the checkpoint box shows up
func _process(delta):	
	$checkpoint/Ui_notification.visible=active
func _on_checkpoint_body_entered(body):
	if body.name == "player":
		active=true
		print("player has entered the checkpoint box")
func _on_checkpoint_body_exited(body):
	if body.name == "player":
		active=false
		print("player has exited the checkpoint box")
