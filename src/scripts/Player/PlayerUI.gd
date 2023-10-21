extends Control

var active_radical = load("res://resources/images/ui/active_aiming_radical.png")

func _ready():
	Input.set_custom_mouse_cursor(active_radical, Input.CURSOR_ARROW)

func _process(delta):
	if ($InventoryContainer.visible):
		$InGameUI.hide()
	elif ($PauseMenuContainer.visible):
		$InGameUI.hide()
	elif ($VendorContainer.visible):
		$InGameUI.hide()
	else:
		$InGameUI.show()
