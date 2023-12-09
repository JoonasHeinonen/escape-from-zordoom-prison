extends Control

var bad_guy_instance
var nodes

var check_is_open = false
var has_open : bool
var has_pause : bool

onready var arena_button = $buttons/ArenaButton
onready var player = get_parent().get_parent()
onready var exit_button = $buttons/ExitButton

const nef_head_preload = preload("res://scenes/NPC/Enemies/nef_head_enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	
func _input(event):
	if (!Globle.arena_menu_open):
		if (Globle.arena_menu_active == true):
			arena_menu_process(true, false)
			show()

func arena_menu_process(has_open, has_pause):
	Globle.update_vendor()
	get_tree().paused = has_open
	get_parent().set_process_input(has_pause)

# Opens the menu.
func opens_Menu():
	if not check_is_open:
		check_is_open = true
		arena_button.grab_focus()
		show()

#Exits out of the menu.
func close_Menu():
	check_is_open  = false
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
	bad_guy_instance = nef_head_preload.instance()
	nodes[0].add_child(bad_guy_instance)
	
# This checks and see if the bad guy/guys in the arena is killed by the player.
func check_current_enemies():
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
