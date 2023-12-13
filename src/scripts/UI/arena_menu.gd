extends Control

const nef_head_preload = preload("res://scenes/NPC/Enemies/nef_head_enemy.tscn")

var has_open : bool
var has_pause : bool
var check_is_open : bool = false

onready var arena_button = $buttons/fight1
onready var player = get_parent().get_parent()
onready var exit_button = $buttons/ExitButton

var bad_guy_instance = null
var nodes = null

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

func opens_menu():
	if not check_is_open:
		check_is_open = true
		arena_button.grab_focus()
		show()
		
func close_menu():
	check_is_open  = false
	Globle.arena_menu_open = false
	hide()

func _on_ExitButton_pressed():
	close_menu()

func _on_ArenaButton_pressed():
	nodes = get_tree().get_nodes_in_group("arenaSpawnPosition")
	if nodes:
		player.global_transform.origin = nodes[0].global_transform.origin
		spawn_bad_guys_in_fight()
	close_menu()

func spawn_bad_guys_in_fight():
	nodes = get_tree().get_nodes_in_group("badGuySpawn1")
	bad_guy_instance = nef_head_preload.instance()
	nodes[0].add_child(bad_guy_instance)

func check_current_enemies():
	nodes = get_tree().get_nodes_in_group("nef_head")
	for node in nodes:
		if !node.is_dead:
			return
	player_wins_fight()

func player_wins_fight():
	nodes = get_tree().get_nodes_in_group("playerReturnPostion")
	if nodes:
		player.global_transform.origin = nodes[0].global_transform.origin
	Globle.bolts += 100
