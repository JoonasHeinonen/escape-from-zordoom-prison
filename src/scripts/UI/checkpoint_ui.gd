extends Area

var active 						 = false
var ui_notification 			 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_checkpoint_body_entered")
	connect("body_exited", self, "_on_checkpoint_body_exited")
	$checkpoint/Ui_notification.visible = false

# When the player enters the collisionshape the checkpoint box shows up.
func _on_checkpoint_body_entered(body):
	if body.name == "player":
		$checkpoint/Ui_notification.show()
		active=true

# When the player exits the collisionshape the checkpoint box goes away.
func _on_checkpoint_body_exited(body):
	# After the player exits the area the box goes away.
	if body.name == "player":
		active = false
		$checkpoint/Ui_notification.hide()
		$checkpoint.hide()
		queue_free()
