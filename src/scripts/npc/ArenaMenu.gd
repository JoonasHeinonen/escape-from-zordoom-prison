extends Control



onready var player     = get_parent().get_parent()

onready var return_btn = $VBoxContainer/CenterRow/Buttons/ReturnToGameButton
onready var btns       = $WeaponsForSale/CenterRow/Buttons

func _ready():
	# gives an error where null instance
	#return_btn.grab_focus()
	hide()
	
func _process(_delta):
	# Hide / show the mouse and the active aiming radical.
	if (self.visible):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _input(event):
	if (!Globle.arena_menu_open):
			#return_btn.grab_focus()
			if (Globle.arena_menu_active == true):
				Arena_Menu_process(true, false)
				show()
	pass

func Arena_Menu_process(var open: bool, var pause: bool):
	Globle.update_vendor()
	get_tree().paused = open
	get_parent().set_process_input(pause)
