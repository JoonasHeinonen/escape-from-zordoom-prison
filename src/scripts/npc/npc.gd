extends Area

export(String, "Mia", "Null NPC", "Girdeux" , "NPC_Angela_Rivet") var character_name

var active : bool = false
var npc_dialog_value : int = 0
var mia_dialog_value : int = 0
var girdeux_dialog_value : int = 0
# clean up varable to have lower case
var NPC_Angela_Rivet_dialog_value : int = 0

var player
var dialog

# Called when the node enters the scene tree for the first time.
func _ready():
	if (character_name == "Girdeux"):
		player = get_parent().get_parent().get_parent().get_parent().get_node('player')
	connect("body_entered", self, "_on_NPC_body_entered")
	connect("body_exited", self, "_on_NPC_body_exited")
	
func _process(delta):
	if (self.has_node("EnterButton")):
		$EnterButton.visible = active
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
						mia_dialog_value = process_dialog_value(mia_dialog_value, 0)
					"Null NPC":
						match(npc_dialog_value):
							(0):
								commence_dialog('timeline-1')
							(2):
								commence_dialog('timeline-2')
							(4):
								commence_dialog('timeline-3')
						npc_dialog_value = process_dialog_value(npc_dialog_value, 4)
					"NPC_Angela_Rivet":
							match(NPC_Angela_Rivet_dialog_value):
								(0):
									commence_dialog('timeline_Rivet_npc_1')
							NPC_Angela_Rivet_dialog_value = process_dialog_value(NPC_Angela_Rivet_dialog_value, 2)
							
	if (Globle.player_character == "Rivet"): 
		if get_node_or_null('DialogNode') == null:
			if Input.is_action_just_pressed("ui_accept") and active == true: 
				match(character_name):
					"Mia":
						match(mia_dialog_value):
							(0):
								commence_dialog('timeline-Mia-Rivet-1')
								mia_dialog_value = process_dialog_value(mia_dialog_value, 0)
					"Null NPC":
						match(npc_dialog_value):
							(0):
								commence_dialog('timeLine-Rivet-1')
							(2):
								commence_dialog('timeLine-Rivet-2')
							(4):
								commence_dialog('timeLine-Rivet-3')
						npc_dialog_value = process_dialog_value(npc_dialog_value, 4)
					"NPC_Angela_Rivet":
							match(NPC_Angela_Rivet_dialog_value):
								(0):
									commence_dialog('timeline_Angela_npc_1')
							NPC_Angela_Rivet_dialog_value = process_dialog_value(NPC_Angela_Rivet_dialog_value, 2)
# Called every frame. 'delta' is the elapsed time since the previous frame.

	# Automated dialogic logic is defined here.
	if (Globle.player_character == "Rivet"): 
		match(character_name):
			"Girdeux":
				if (player.boss_fight_active):
					match(girdeux_dialog_value):
						(0):
							commence_dialog('timeline-girdeux')
					girdeux_dialog_value = process_dialog_value(girdeux_dialog_value, 4)
	elif (Globle.player_character == "Angela"):
		match(character_name):
			"Girdeux":
				if (player.boss_fight_active):
					match(girdeux_dialog_value):
						(0):
							commence_dialog('timeline-girdeux')
					girdeux_dialog_value = process_dialog_value(girdeux_dialog_value, 4)
	
							

## Process the dialog values for dialogs.
func process_dialog_value(dialog_value : int, max_value : int):
	dialog_value += 1
	if dialog_value > max_value and active:
		dialog_value = max_value
		active = false
	return dialog_value

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
