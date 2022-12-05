extends Area

var active = false
var value  = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	# connect("body_entered",self,"_on_NPC_body_entered")
	# connect("body_exited",self,"_on_NPC_body_exited")

func _input(event):
	if Input.is_action_just_pressed("ui_accept") and active == true: 
		print(active)

func _on_slim_cognito_body_entered(body):
	if body.name == "player":
		active = true
		print("body has entered the npc")

func _on_slim_cognito_body_exited(body):
	if body.name == "player":
		active = false
		print("body has exited the npc")
