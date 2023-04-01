extends Area

var active = false

var ui_notification				 = false

	#When the player enters the collisionshape the checkpoint box shows up
func _ready():
	connect("body_entered",self,"_on_checkpoint_body_entered")
	connect("body_exited",self,"_on_checkpoint_body_exited")
	$checkpoint/Ui_notification.visible=false
func _process(delta):	
	pass
	
	
func _on_checkpoint_body_entered(body):
	if body.name == "player":
		$checkpoint/Ui_notification.show()
		print("player has entered the checkpoint box")
		
func _on_checkpoint_body_exited(body):
	if body.name == "player":
		active=false
		print("player has exited the checkpoint box")
		$checkpoint/Ui_notification.hide()
		$checkpoint.hide()
