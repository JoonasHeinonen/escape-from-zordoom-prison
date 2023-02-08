extends Control

onready var new_game_button  = $VBoxContainer/CenterRow/Buttons/NewGameButton
onready var load_game_button = $VBoxContainer/CenterRow/Buttons/LoadGameButton
onready var options_button   = $VBoxContainer/CenterRow/Buttons/OptionsButton

# Called when the node enters the scene tree for the first time.
func _ready():
	$Audio/Click.play()
	get_tree().paused = false

	# Set the active button.
	match Globle.menu_to_return:
		"LoadGame":
			load_game_button.grab_focus()
		"Options":
			options_button.grab_focus()
		"CharacterSelection":
			new_game_button.grab_focus()
		_:
			new_game_button.grab_focus()

	for button in $VBoxContainer/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

# Loads the scene defined to a particular button.
func _on_Button_pressed(scene_to_load):
	print("Scene: " + scene_to_load)
	get_tree().change_scene(scene_to_load)

# Run when FadeIn fade is finished.
func _on_FadeIn_fade_finished():
	pass # Leave this empty, for now.

func _on_OptionsButton_pressed():
	pass # Replace with function body.

func _on_OptionsButton_focus_entered():
	pass # Replace with function body.
