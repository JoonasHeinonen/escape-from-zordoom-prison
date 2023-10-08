extends Control


onready var player     = get_parent().get_parent()
onready var area_button = $buttons/ArenaButton
onready var exit_button = $buttons/ExitButton
var is_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func _process(_delta):
	# Hide / show the mouse and the active aiming radical.
	if (Globle.arena_menu_active == true):
			Arena_Menu_process(true, false)
			open()

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
		area_button.grab_focus()
#exit out of the menue
func close():
	if is_open:
		is_open = false
		hide()
