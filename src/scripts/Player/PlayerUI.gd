extends Control

var active_radical = load("res://resources/images/ui/active_aiming_radical.png")

func _ready():
	Input.set_custom_mouse_cursor(active_radical, Input.CURSOR_ARROW)

func _process(delta):
	# Fullscreen (1920, 1080)
	# Windowed   (1296, 759)
	if ($InventoryContainer.visible):
		$InGameUI.hide()
		$FullscreenInGameUI.hide()
	elif ($PauseMenuContainer.visible):
		$InGameUI.hide()
		$FullscreenInGameUI.hide()
	elif ($VendorContainer.visible):
		$InGameUI.hide()
		$FullscreenInGameUI.hide()
	else:
		if (Globle.game_fullscreen):
			$InGameUI.hide()
			$FullscreenInGameUI.show()
		elif (!Globle.game_fullscreen):
			$InGameUI.show()
			$FullscreenInGameUI.hide()
