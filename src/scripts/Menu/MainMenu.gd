extends Control

var scene_path_to_load

# Called when the node enters the scene tree for the first time.
func _ready():
	button_focus()
	for button in $VBoxContainer/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

# Loads the scene defined to a particular button.
func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()

# Sets the focused button.
func button_focus():
	var index_button = $VBoxContainer/CenterRow/Buttons/NewGameButton
	index_button.grab_focus()

# Run when FadeIn fade is finished.
func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)