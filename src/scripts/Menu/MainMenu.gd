extends Control

onready var new_game_button = $CenterContainer/Buttons/NewGameButton
onready var load_game_button = $CenterContainer/Buttons/LoadGameButton
onready var options_button = $CenterContainer/Buttons/OptionsButton

onready var camera = get_parent().get_node("Camera")
onready var character_Selection = get_parent().get_node("CharacterSelection")
onready var load_game = get_parent().get_node("LoadGame")
onready var options = get_parent().get_node("Options")

var random = RandomNumberGenerator.new()

func _ready():
	random.randomize()
	$Audio/Click.play()

	get_tree().paused = false
	self.visible = true
	character_Selection.visible = false
	options.visible = false
	load_game.visible = false

	match Globle.menu_to_return:
		"LoadGame":
			load_game_button.grab_focus()
		"Options":
			options_button.grab_focus()
		"CharacterSelection":
			new_game_button.grab_focus()
		_:
			new_game_button.grab_focus()

	for button in $CenterContainer/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func _physics_process(_delta):
	camera.rotation += Vector3(0.001, 0.002, 0)

func _on_Button_pressed(scene_to_load):
	print("Scene: " + scene_to_load)
	get_tree().change_scene(scene_to_load)

func _on_FadeIn_fade_finished():
	pass # Leave this empty, for now.

func _on_OptionsButton_pressed():
	pass # Replace with function body.

func _on_OptionsButton_focus_entered():
	pass # Replace with function body.
