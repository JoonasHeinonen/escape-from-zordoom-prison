extends Area

var active = false
onready var ui_timer = $checkpoint/Timer
var ui_notification				 = false
func _ready():
	connect("body_entered",self,"_on_checkpoint_body_entered")
	connect("body_exited",self,"_on_checkpoint_body_exited")
	ui_timer.connect("timeout", self, "_on_UI_Timer_timeout")
	
func _process(delta):	
	$checkpoint/Ui_notification.visible=active
	_on_UI_Timer_timeout()
func _on_checkpoint_body_entered(body):
	if body.name == "player" :
		ui_timer.start()
		ui_notification = true
		active = true
		print("player has entered the checkpoint box")
		
		
func _on_UI_Timer_timeout():
	if (ui_notification):
		ui_notification = false
		$checkpoint/Ui_notification.hide()
		print(ui_timer)
