extends Area

var active = false
onready var ui_timer = $checkpoint/Ui_notification/Timer
var ui_notification				 = false

	#When the player enters the collisionshape the checkpoint box shows up
func _ready():
	connect("body_entered",self,"_on_checkpoint_body_entered")
	connect("body_exited",self,"_on_checkpoint_body_exited")
	ui_timer.connect("timeout",self,"_on_UI_Timer_timeout")
	$checkpoint/Ui_notification.visible=false
func _process(delta):	
	_on_UI_Timer_timeout()
	
	
func _on_checkpoint_body_entered(body):
	if body.name == "player":
		$checkpoint/Ui_notification.show()
		print("player has entered the checkpoint box")
func _on_checkpoint_body_exited(body):
	if body.name == "player":
		active=false
		#_on_UI_Timer_timeout()
		print("player has exited the checkpoint box")
		$checkpoint/Ui_notification.hide()
		$checkpoint/Area/CollisionShape.hide()
func _on_UI_Timer_timeout():
	if (ui_notification):
		ui_notification = false
		$checkpoint/Ui_notification.hide()
		#$checkpoint/Area/CollisionShape.hide()
