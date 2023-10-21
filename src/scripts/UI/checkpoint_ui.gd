extends Area

var active = false
var ui_notification = false

func _ready():
	connect("body_entered", self, "_on_checkpoint_body_entered")
	connect("body_exited", self, "_on_checkpoint_body_exited")
	$checkpoint/Ui_notification.visible = false

func _on_checkpoint_body_entered(body):
	if body.name == "player":
		$checkpoint/Ui_notification.show()
		active = true

func _on_checkpoint_body_exited(body):
	if body.name == "player":
		active = false
		$checkpoint/Ui_notification.hide()
		$checkpoint.hide()
		queue_free()
