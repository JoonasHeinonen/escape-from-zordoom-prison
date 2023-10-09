extends Control


onready var player     = get_parent().get_parent()
onready var arena_button = $buttons/ArenaButton
onready var exit_button = $buttons/ExitButton
var is_open = false
onready var spawn_point = $arena/PlayerSpawnArea
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

#try and get the sence to reload with a different postion
func _on_ArenaButton_pressed():
	#print(spawn_point.position)
	player.global_transform.origin.z=19
	close()
	pass # Replace with function body.
