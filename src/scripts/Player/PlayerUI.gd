extends Control

onready var in_game_ui_right_elements = [
	$InGameUI/Ammo,
	$InGameUI/Bolts
]

var active_radical = load("res://resources/images/ui/active_aiming_radical.png")

func _ready():
	Input.set_custom_mouse_cursor(active_radical, Input.CURSOR_ARROW)

func _process(delta):
	for element in in_game_ui_right_elements:
		if (element is Control):
				element.margin_left = get_viewport().size.x - 350
				in_game_ui_right_elements[1].margin_top = get_viewport().size.y - 150

	if ($InventoryContainer.visible):
		$InGameUI.hide()
	elif ($PauseMenuContainer.visible):
		$InGameUI.hide()
	elif ($VendorContainer.visible):
		$InGameUI.hide()
	else:
		$InGameUI.show()
