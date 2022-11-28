extends Control

var time_scale_target = 1
var interpolation     = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func _input(event):
	if (!get_tree().paused):
		if event.is_action_pressed("ui_inventory"):
			Globle.player_inventory = true
			time_scale_target = 0
			interpolation     = 0
			get_parent().set_process_input(false)
			show()
		if event.is_action_released("ui_inventory"):
			Globle.player_inventory = false
			time_scale_target = 1
			Engine.time_scale = 1
			get_parent().set_process_input(true)
			hide()

func _physics_process(delta):
	if interpolation <= 1:
		interpolation += delta
	Engine.time_scale = lerp(Engine.time_scale, time_scale_target, interpolation)
