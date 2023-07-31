extends Area

export(String, "Mia", "Null NPC", "Girdeux") var character_name

var active : bool = false
var npc_dialog_value : int = 0
var mia_dialog_value : int = 0
var girdeux_dialog_value : int = 0

var dialog

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_NPC_body_entered")
	connect("body_exited", self, "_on_NPC_body_exited")

# Called when there is an input event.
func _input(event):
	if (Globle.player_character == "Angela"):
		if get_node_or_null('DialogNode') == null:
			if Input.is_action_just_pressed("ui_accept") and active: 
				match(character_name):
					"Mia":
						match(mia_dialog_value):
							(0):
								commence_dialog('timeline-Mia-angela-1')
						mia_dialog_value += 1
						if mia_dialog_value > 0 and active:
							mia_dialog_value = 1
							active = false
					"Null NPC":
						match(npc_dialog_value):
							(0):
								commence_dialog('timeline-1')
							(2):
								commence_dialog('timeline-2')
							(4):
								commence_dialog('timeline-3')
						npc_dialog_value += 1
						if npc_dialog_value > 4 and active:
							npc_dialog_value = 4
							active = false
					"Girdeux":
						girdeux_dialog_value += 1
						if girdeux_dialog_value > 0 and active:
							girdeux_dialog_value = 0
							active = false
	if (Globle.player_character == "Rivet"): 
		if get_node_or_null('DialogNode') == null:
			if Input.is_action_just_pressed("ui_accept") and active == true: 
				match(character_name):
					"Mia":
						match(mia_dialog_value):
							(0):
								commence_dialog('timeline-Mia-Rivet-1')
								mia_dialog_value += 1
								if mia_dialog_value > 0 and active:
									mia_dialog_value = 1
									active = false
					"Null NPC":
						match(npc_dialog_value):
							(0):
								commence_dialog('timeLine-Rivet-1')
							(2):
								commence_dialog('timeLine-Rivet-2')
							(4):
								commence_dialog('timeLine-Rivet-3')
						npc_dialog_value += 1
						if npc_dialog_value > 4 and active:
							npc_dialog_value = 4
							active = false
					"Girdeux":
						girdeux_dialog_value += 1
						if girdeux_dialog_value > 4 and active:
							girdeux_dialog_value = 4
							active = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$EnterButton.visible = active

## Commences the dialog, pauses the game.
func commence_dialog(timeline : String):
	get_tree().paused = true
	var dialog = Dialogic.start(timeline)
	dialog.pause_mode = Node.PAUSE_MODE_PROCESS
	dialog.connect('timeline_end',self,'unpause')
	add_child(dialog)

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
