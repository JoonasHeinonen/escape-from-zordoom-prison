extends Area

var active = false

var ui_notification				 = false

	#When the player enters the collisionshape the checkpoint box shows up
func _ready():
	connect("body_entered",self,"_on_checkpoint_body_entered")
	connect("body_exited",self,"_on_checkpoint_body_exited")
	#$checkpoint/Area/checkpoint/Ui_notification.visible=false
	
func _on_checkpoint_body_entered(body):
	#after the player enters the area the box shows up
	if body.name == "player":
		#$checkpoint/Ui_notification.show()
		active = true
		
func _on_checkpoint_body_exited(body):
	#after the player exits the area the box goes away
	if body.name == "player":
		active = false
		#$checkpoint/Ui_notification.hide()
		queue_free()


