extends Area3D

@export var character_name : String # (String, "Mia", "Null NPC", "Girdeux" , "NPC_Angela_Rivet", "Shark_man")

var active : bool = false

var npc_dialog_value : int = 0
var mia_dialog_value : int = 0
var girdeux_dialog_value : int = 0
var npc_angela_rivet_dialog_value : int = 0
var shark_man_dialog_value : int = 0

var player
var dialog

func _ready():
	if (character_name == "Girdeux"):
		player = get_parent().get_parent().get_parent().get_parent().get_node('player')
	connect("body_entered", Callable(self, "_on_NPC_body_entered"))
	connect("body_exited", Callable(self, "_on_NPC_body_exited"))
func _process(delta):
	if (self.has_node("EnterButton")):
		$EnterButton.visible = active

func _input(event):
	if (Globle.player_character == "Angela" and get_node_or_null('DialogNode') == null and Input.is_action_just_pressed("ui_accept") and active):
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
						match(npc_angela_rivet_dialog_value):
							(0):
								commence_dialog('timeline_Rivet_npc_1')
								npc_angela_rivet_dialog_value = process_dialog_value(npc_angela_rivet_dialog_value, 2)
					"Shark_man":
						match(shark_man_dialog_value):
							(0):
								print("checks dialogic")
								commence_dialog('test_timeline')
								shark_man_dialog_value = process_dialog_value(npc_angela_rivet_dialog_value, 1)
							(1):
								print(shark_man_dialog_value)
								Globle.arena_menu_open = true
	if (Globle.player_character == "Rivet" and get_node_or_null('DialogNode') == null and Input.is_action_just_pressed("ui_accept") and active == true):
		match(character_name):
			"Mia":
				match(mia_dialog_value):
					(0):
						commence_dialog('timeline-Mia-Rivet-1')
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
				match(npc_angela_rivet_dialog_value):
					(0):
						commence_dialog('timeline_Rivet_npc_1')
				npc_angela_rivet_dialog_value = process_dialog_value(npc_angela_rivet_dialog_value, 2)
			"Shark_man":
				match(shark_man_dialog_value):
					(0):
						commence_dialog('timeline_Rivet_shark_man')
						get_viewport().set_input_as_handled()
				shark_man_dialog_value = process_dialog_value(npc_angela_rivet_dialog_value, 0)
				Globle.arena_menu_open = true
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
						match(npc_angela_rivet_dialog_value):
							(0):
								#Re-due menue logic.
								commence_dialog('timeline_Angela_npc_1')
						npc_angela_rivet_dialog_value = process_dialog_value(npc_angela_rivet_dialog_value, 2)
					"Shark_man":
						match(shark_man_dialog_value):
							(0):
								#Re-due menue logic.
								commence_dialog('timeline_Rivet_shark_man')
						shark_man_dialog_value = process_dialog_value(npc_angela_rivet_dialog_value, 0)

	if (self.has_node("EnterButton")):
		$EnterButton.visible = active
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

func process_dialog_value(dialog_value : int, max_value : int):
	dialog_value += 1
	if dialog_value > max_value and active:
		dialog_value = max_value
		active = false
	return dialog_value

func commence_dialog(timeline : String):
	# when trying to pause the game we can get the menue but get another error called invalid call. Nonexistent function 'remove' in base array
	get_tree().paused = false
	var dialog = Dialogic.start(timeline)
	get_viewport().set_input_as_handled()
	#need to check and see if the arena menu is being called correctly 
	dialog.process_mode = Node.PROCESS_MODE_ALWAYS
	dialog.connect('timeline_ended', Callable(self, 'unpause'))
	add_child(dialog)
	print(Globle.arena_menu_open)

# Unpauses the game timeline.
func unpause(timeline_name):
	print("checks if the menu shows up in this unpause function")
	get_tree().paused = false

# Acts when the player has entered the NPC body.
func _on_NPC_body_entered(body):
	if body.name == "player":
		active = true

# Acts when the player has left the NPC body.
func _on_NPC_body_exited(body):
	if body.name == "player":
		active = false
