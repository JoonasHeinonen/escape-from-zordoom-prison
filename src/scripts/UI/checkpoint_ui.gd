extends Area3D

var is_active = false

func _ready():
	connect("body_entered", Callable(self, "_on_checkpoint_body_entered"))
	connect("body_exited", Callable(self, "_on_checkpoint_body_exited"))
	$checkpoint/Ui_notification.visible = false

func _on_checkpoint_body_entered(body):
	if body.name == "player":
		$checkpoint/Ui_notification.show()
		is_active = true

func _on_checkpoint_body_exited(body):
	if body.name == "player":
		is_active = false
		$checkpoint/Ui_notification.hide()
		$checkpoint.hide()
		queue_free()
