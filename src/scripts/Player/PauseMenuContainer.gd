extends Control

var time_scale_target = 1
var interpolation     = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func _input(event):
	if event.is_action_pressed("ui_esc"):
		show() if !self.visible else hide()

func _physics_process(delta):
	if (!self.visible):
		interpolation = 0
		time_scale_target = 0
		get_parent().set_process_input(true)
	else:
		interpolation = 1
		Engine.time_scale = 1
		get_parent().set_process_input(false)

	if interpolation <= 1:
		interpolation += delta
	Engine.time_scale = lerp(Engine.time_scale, time_scale_target, interpolation)

# Returns to the game.
func _on_ReturnToGameButton_pressed():
	hide()

# Returns to the main menu.
func _on_ReturnToMainMenuButton_pressed():
	get_tree().change_scene("res://scenes/Menu/MainMenu.tscn")
