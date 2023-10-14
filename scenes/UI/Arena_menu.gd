extends Control


onready var player     = get_parent().get_parent()
onready var arena_button = $buttons/ArenaButton
onready var exit_button = $buttons/ExitButton
const bad_guy_nef_head = preload("res://scenes/NPC/Enemies/nef_head_enemy.tscn")
var is_open = false

var bad_guys_is_dead = false
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	
func _input(event):
	if (!Globle.arena_menu_open):
			#return_btn.grab_focus()
			if (Globle.arena_menu_active == true):
				Arena_Menu_process(true, false)
				show()

func Arena_Menu_process(var open: bool, var pause: bool):
	Globle.update_vendor()
	get_tree().paused = open
	get_parent().set_process_input(pause)

# open the menue
func open():
	if not is_open:
		is_open = true
		show()
		print("open")
		arena_button.grab_focus()
#exit out of the menue
func close():
	is_open = false
	Globle.arena_menu_open = false
	print('close')
	print(Globle.arena_menu_open)
	hide()
#https://www.youtube.com/watch?v=rZRVb5rkALM
func _on_ExitButton_pressed():
	close()
	pass # Replace with function body.


func _on_ArenaButton_pressed():
	var nodes = get_tree().get_nodes_in_group("arenaSpawnPosition")
	if nodes:
		player.global_transform.origin = nodes[0].global_transform.origin
		spawn_bad_guys_fight_1()
	close()
	

func spawn_bad_guys_fight_1():
	var nodes = get_tree().get_nodes_in_group("badGuySpawn1")
	var badGuy = bad_guy_nef_head.instance()
	nodes[0].add_child(badGuy)
# this checks and see if the nef head in the arena is killed by the player
func check_nef_head_is_dead():
	var nodes = get_tree().get_nodes_in_group("nef_head")
	for node in nodes:
		if !node.is_dead :
			return 
	print("check")
	
