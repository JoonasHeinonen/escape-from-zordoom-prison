extends Area

var active = false
var value  = 0
var dialog

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_NPC_body_entered")
	connect("body_exited", self, "_on_NPC_body_exited")
	
func _input(event):
	if get_node_or_null('DialogNode') == null:
			if Input.is_action_just_pressed("ui_accept") and active == true: 
				match(value):
					(0):
						get_tree().paused = true
						var dialog = Dialogic.start('timeline-1')
						dialog.pause_mode = Node.PAUSE_MODE_PROCESS
						dialog.connect('timeline_end', self, 'unpause')
						add_child(dialog)
					(2):
						
						get_tree().paused = true
						var dialog = Dialogic.start('timeline-2')
						dialog.pause_mode = Node.PAUSE_MODE_PROCESS
						dialog.connect('timeline_end', self, 'unpause')
						add_child(dialog)
					(4):
						
						get_tree().paused = true
						var dialog = Dialogic.start('timeline-3')
						dialog.pause_mode = Node.PAUSE_MODE_PROCESS
						dialog.connect('timeline_end', self, 'unpause')
						add_child(dialog)
				value += 1
				if value > 4 and active == true:
					value = 4
					active = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$EnterButton.visible = active

# Unpauses the game timeline.
func unpause(timeline_name):
	get_tree().paused = false

# Acts when the player has entered the NPC body.
func _on_NPC_body_entered(body):
	if body.name == "player":
		active = true

# Acts when the player has left the NPC body.
func _on_NPC_body_exited(body):
	if body.name == "player":
		active = false
