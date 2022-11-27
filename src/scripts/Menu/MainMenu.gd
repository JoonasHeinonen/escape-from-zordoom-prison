extends Control

onready var index_button = $VBoxContainer/CenterRow/Buttons/NewGameButton

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	index_button.grab_focus()
	for button in $VBoxContainer/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

# Loads the scene defined to a particular button.
func _on_Button_pressed(scene_to_load):
	print("Scene: " + scene_to_load)
	get_tree().change_scene(scene_to_load)

# Run when FadeIn fade is finished.
func _on_FadeIn_fade_finished():
	pass # Leave this empty, for now.
