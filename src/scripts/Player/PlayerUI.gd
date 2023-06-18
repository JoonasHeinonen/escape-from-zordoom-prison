extends Control

# Load the custom images for the mouse cursor
var active_radical = load("res://resources/images/ui/green_aiming_radical.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	print(active_radical)
	Input.set_custom_mouse_cursor(active_radical, Input.CURSOR_ARROW)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Determines whether or not the `InGameUI` should be visible.
	if ($InventoryContainer.visible):
		$InGameUI.hide()
	elif ($PauseMenuContainer.visible):
		$InGameUI.hide()
	elif ($VendorContainer.visible):
		$InGameUI.hide()
	else:
		$InGameUI.show()
