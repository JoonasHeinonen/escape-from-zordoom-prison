extends Control



onready var player     = get_parent().get_parent()
onready var area_button = $VBoxContainer/ArenaButton
onready var exit_button = $VBoxContainer/ExitButton

var is_open = false

# Hide / show the mouse and the active aiming radical.
func _ready():
	hide()

	

func _input(event):
	if (!Globle.arena_menu_open):
		if (Globle.arena_menu_active == true):
			Arena_Menu_process(true, false)
			open()

func Arena_Menu_process(var open: bool, var pause: bool):
	Globle.update_vendor()
	get_tree().paused = open
	get_parent().set_process_input(pause)


func _on_ArenaButton_pressed():
	pass # Replace with function body.


#source : https://www.youtube.com/watch?time_continue=104&v=Mx3iyz8AUAE&embeds_referring_euri=https%3A%2F%2Fduckduckgo.com%2F&feature=emb_title


func _on_ExitButton_pressed():
	close()



func _on_ArenaMenu_visibility_changed():
	if (self.visible):
		print("test")
		#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
# open the menue
func open():
	if not is_open:
		is_open = true
		show()
		print("open")
		
#exit out of the menue
func close():
	is_open = false
	Globle.arena_menu_open = false
	print('close')
	print(Globle.arena_menu_open)
	hide()
