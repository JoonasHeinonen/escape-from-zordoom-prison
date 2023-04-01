extends Area

var active = false
onready var ui_timer = $checkpoint/Area/checkpoint/Ui_notification/Timer
var ui_notification				 = false

	#When the player enters the collisionshape the checkpoint box shows up
func _ready():
	connect("body_entered",self,"_on_checkpoint_body_entered")
	connect("body_exited",self,"_on_checkpoint_body_exited")

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
