extends MenuSceneControlBase

const nef_head_preload = preload("res://scenes/NPC/Enemies/nef_head_enemy.tscn")

@onready var arena_button = $VBoxContainer/HBoxContainer/FightButtons/Fight1
@onready var exit_button = $VBoxContainer/HBoxContainer/FightButtons/ExitButton
@onready var player = get_tree().get_root().get_node("Level/player")

var bad_guy_instance = null
var nodes = null

var has_open : bool
var has_pause : bool
var check_is_open : bool = false

func _ready():
	hide()

func _process(_delta):
	if (Globle.arena_menu_open && self.visible):
		Globle.player_active = false
		arena_button.grab_focus()

func arena_menu_process(is_vendor_open, is_paused):
	Globle.update_vendor()

func opens_menu():
	if not check_is_open:
		check_is_open = true
		arena_button.grab_focus()
		arena_menu_process(true, false)
		show()
		
func close_menu():
	check_is_open  = false
	Globle.arena_menu_open = false
	Globle.player_active = true
	arena_menu_process(false, true)
	hide()

func spawn_bad_guys_in_fight():
	# nodes = get_tree().get_nodes_in_group("badGuySpawn1")
	# bad_guy_instance = nef_head_preload.instantiate()
	# nodes[0].add_child(bad_guy_instance)
	var enemies_node = get_parent().get_parent().get_parent().get_node("npc/enemies")
	var spawn_point = get_parent().get_parent().get_parent().get_node("badGuySpawn1")

	bad_guy_instance = nef_head_preload.instantiate()
	bad_guy_instance.global_transform = spawn_point.global_transform
	enemies_node.add_child(bad_guy_instance)

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

func _on_ExitButton_pressed():
	close_menu()

func _on_ArenaButton_pressed():
	nodes = get_tree().get_nodes_in_group("arenaSpawnPosition")
	if nodes:
		player.global_transform.origin = nodes[0].global_transform.origin
		spawn_bad_guys_in_fight()
	close_menu()
