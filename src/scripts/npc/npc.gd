extends Area3D

class_name NPC

@export_enum("Mia", "Girdeux" , "NPC_Angela_Rivet", "Shark_man", "F44") var character_name: String

var active : bool = false
var trigger_cutscene : bool = false
var cutscene_ended : bool = false
var npc_dialog_value : int = 0
var mia_dialog_value : int = 0
var girdeux_dialog_value : int = 0
var npc_angela_rivet_dialog_value : int = 0
var shark_man_dialog_value : int = 0
var min : int = 0
var max : int = 8

var player
var dialog

func _ready():
	if (character_name == "Girdeux"):
		player = get_parent().get_parent().get_parent().get_parent().get_node('player')
	connect("body_entered", Callable(self, "_on_NPC_body_entered"))
	connect("body_exited", Callable(self, "_on_NPC_body_exited"))

func _process(_delta):
	if (self.has_node("EnterButton")):
		$EnterButton.visible = active
	boss_fight_dialog()

func _input(_event):
	if (self.has_node("EnterButton")):
		$EnterButton.visible = active
	npc_dialog()

func npc_dialog():
	if (Globle.player_character == "Angela" and get_node_or_null('DialogNode') == null and Input.is_action_just_pressed("ui_accept") and active):
		if get_node_or_null('DialogNode') == null:
			if Input.is_action_just_pressed("ui_accept") and active: 
				match(character_name):
					"Mia":
						match(mia_dialog_value):
							(0):
								Globle.player_active = false
								commence_dialog('Mia_Angela_timeline')
								mia_dialog_value = process_dialog_value(npc_angela_rivet_dialog_value,2)
							(2):
								mia_dialog_value = process_dialog_value(npc_angela_rivet_dialog_value, 0)
								Globle.player_active = true
					"NPC_Angela_Rivet":
						match(npc_angela_rivet_dialog_value):
							(0):
								commence_dialog('timeline_Rivet_npc_1')
								npc_angela_rivet_dialog_value = process_dialog_value(npc_angela_rivet_dialog_value, 2)
					"Shark_man":
						match(shark_man_dialog_value):
							(0):
								Globle.arena_menu_open = false
								Globle.player_active = false
								commence_dialog('timeline_Angela_shark_man')
								shark_man_dialog_value = process_dialog_value(npc_angela_rivet_dialog_value, 2)
							(1):
								shark_man_dialog_value = process_dialog_value(npc_angela_rivet_dialog_value, 0)
								Globle.player_active = true
								Globle.arena_menu_open = true
					"F44":
						print("Ce soir la vie n'est plus un enfer pour 1 fois.")
	if (Globle.player_character == "Rivet" and get_node_or_null('DialogNode') == null and Input.is_action_just_pressed("ui_accept") and active == true):
		match(character_name):
			"Mia":
				match(mia_dialog_value):
					(0):
						Globle.player_active = false
						commence_dialog('Mia_Rivet_timeline')
						mia_dialog_value = process_dialog_value(mia_dialog_value, 2)
					(2):
						mia_dialog_value = process_dialog_value(npc_angela_rivet_dialog_value, 0)
						Globle.player_active = true
			"NPC_Angela_Rivet":
				match(npc_angela_rivet_dialog_value):
					(0):
						commence_dialog('timeline_Angela_npc_1')
				npc_angela_rivet_dialog_value = process_dialog_value(npc_angela_rivet_dialog_value, 2)
			#why is there two if statments checking if the player is rivet or not?
			"Shark_man":
				match(shark_man_dialog_value):
					(0):
						Globle.arena_menu_open = false
						Globle.player_active = false
						commence_dialog('timeline_Rivet_shark_man')
						shark_man_dialog_value = process_dialog_value(npc_angela_rivet_dialog_value, 2)
					(1):
						shark_man_dialog_value = process_dialog_value(npc_angela_rivet_dialog_value, 0)
						Globle.player_active = true
						Globle.arena_menu_open = true
			"F44":
				print("Ce soir la vie n'est plus un enfer pour 2 fois.")

func boss_fight_dialog():
	if (Globle.player_character == "Rivet"): 
		match(character_name):
			"Girdeux":
				if player.boss_fight_active and trigger_cutscene == false:
					commence_dialog('Girdeux_Rivet_Timeline1')
					trigger_cutscene = true

	if (Globle.player_character == "Angela"):
		match(character_name):
			"Girdeux":
				if player.boss_fight_active and trigger_cutscene == false:
					commence_dialog('Girdeux_Angela_Timeline1')
					trigger_cutscene = true
					#match(girdeux_dialog_value):
						#(0):
							#Globle.player_active = false
						#(2):
							#Globle.player_active = true
					#girdeux_dialog_value = process_dialog_value(girdeux_dialog_value, 2)

func process_dialog_value(dialog_value : int, max_value : int):
	dialog_value += 1
	if dialog_value > max_value and active:
		dialog_value = max_value
		active = false
	return dialog_value

func commence_dialog(timeline : String):
	#get_tree().paused = false
	Globle.player_active = false
	Dialogic.timeline_ended.connect(unpause)
	Dialogic.start(timeline)
	get_viewport().set_input_as_handled()
	#add_child(dialog)
	#dialog.process_mode = Node.PROCESS_MODE_ALWAYS
	#dialog.connect('timeline_ended', Callable(self, 'unpause'))

# Unpauses the game timeline.
func unpause():
	#get_tree().paused = false
	Dialogic.timeline_ended.disconnect(unpause)
	Globle.player_active = true
	cutscene_ended = true

# Acts when the player has entered the NPC body.
func _on_NPC_body_entered(body):
	if body.name == "player":
		active = true

# Acts when the player has left the NPC body.
func _on_NPC_body_exited(body):
	if body.name == "player":
		active = false
