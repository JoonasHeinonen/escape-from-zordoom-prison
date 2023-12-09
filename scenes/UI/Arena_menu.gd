extends Control

var badGuy
var nodes

var is_open = false
var open : bool
var pause : bool

onready var arena_button = $buttons/ArenaButton
onready var player     = get_parent().get_parent()
onready var exit_button = $buttons/ExitButton

const bad_guy_nef_head = preload("res://scenes/NPC/Enemies/nef_head_enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	
func _input(event):
	if (!Globle.arena_menu_open):
		if (Globle.arena_menu_active == true):
			Arena_Menu_process(true, false)
			show()

func Arena_Menu_process(open, pause):
	Globle.update_vendor()
	get_tree().paused = open
	get_parent().set_process_input(pause)

# Opens the menu.
func opens_Menu():
	if not is_open:
		is_open = true
		arena_button.grab_focus()
		show()

#Exits out of the menu.
func close_Menu():
	is_open = false
	Globle.arena_menu_open = false
	hide()

func _on_ExitButton_pressed():
	close_Menu()
	 
func _on_ArenaButton_pressed():
	nodes = get_tree().get_nodes_in_group("arenaSpawnPosition")
	
	if nodes:
		player.global_transform.origin = nodes[0].global_transform.origin
		spawn_bad_guys_in_fight_1()
	
	close_Menu()
	
#These fuctions handle the fight_1 we have laid the ground work to expaned 
#and add on where we can do as many fights/challenges as we can code in this one script!
func spawn_bad_guys_in_fight_1():
	nodes = get_tree().get_nodes_in_group("badGuySpawn1")
	badGuy = bad_guy_nef_head.instance()
	nodes[0].add_child(badGuy)
	
# This checks and see if the bad guy/guys in the arena is killed by the player.
func check_nef_head_is_dead():
	nodes = get_tree().get_nodes_in_group("nef_head")
	
	for node in nodes:
		if node.is_dead:
			player_wins_fight_1()
			return
#Player returns to shark man and the fight starts over again.
func player_wins_fight_1():
	nodes = get_tree().get_nodes_in_group("playerReturnPostion")
	
	if nodes:
		player.global_transform.origin = nodes[0].global_transform.origin
	
	Globle.bolts += 100
