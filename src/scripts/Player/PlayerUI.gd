extends Control

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
