extends MenuSceneControlBase

@onready var new_game_button = $CenterContainer/Buttons/NewGameButton
@onready var load_game_button = $CenterContainer/Buttons/LoadGameButton
@onready var options_button = $CenterContainer/Buttons/OptionsButton

@onready var camera = get_parent().get_node("Camera3D")
@onready var character_selection = get_parent().get_node("CharacterSelection")
@onready var load_game = get_parent().get_node("LoadGame")
@onready var options = get_parent().get_node("Options")
@onready var main_menu = get_parent().get_node("MainMenu")

var random = RandomNumberGenerator.new()

func _ready():
	random.randomize()
	$Audio/Click.play()

	get_tree().paused = false
	main_menu.visible = false
	character_selection.visible = false
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
		button.connect("pressed", Callable(self, "_on_Button_pressed").bind(button.scene_to_load))

func _process(_delta):
	alignment = "Full alignment"

func _physics_process(_delta):
	camera.rotation += Vector3(0.001, 0.002, 0)

func _on_Button_pressed(scene_to_load):
	get_tree().change_scene_to_file(scene_to_load)

func _on_FadeIn_fade_finished():
	pass # Leave this empty, for now.

func _on_OptionsButton_pressed():
	pass # Replace with function body.

func _on_OptionsButton_focus_entered():
	pass # Replace with function body.
