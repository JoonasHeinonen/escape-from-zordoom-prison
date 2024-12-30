extends Control

@onready var boss_health_bar = $UIBossData/UIBossDataCenterContainer/CenterContainer/BossHealthBar
@onready var boss_health_percentage = $UIBossData/UIBossDataCenterContainer/CenterContainer/BossHealthPercentage
@onready var in_game_ui_right_elements = [
	$InGameUI/Ammo,
	$InGameUI/Bolts
]

var active_radical = load("res://resources/images/ui/active_aiming_radical.png")

func _ready():
	Input.set_custom_mouse_cursor(active_radical, Input.CURSOR_ARROW)

func _process(_delta):
	for element in in_game_ui_right_elements:
		if (element is Control):
				element.offset_left = get_viewport().size.x - 350
				in_game_ui_right_elements[1].offset_top = get_viewport().size.y - 150
	boss_health_percentage.offset_left = 387
	boss_health_percentage.offset_top = 20
	boss_health_percentage.offset_right = 246
	boss_health_percentage.offset_bottom = 20
	boss_health_bar.offset_left = 12
	boss_health_bar.offset_top = 55
	boss_health_bar.offset_right = 418
	boss_health_bar.offset_bottom = 77
	boss_health_bar.size = Vector2(406, 22)

	if ($InventoryContainer.visible):
		$InGameUI.hide()
	elif ($PauseMenuContainer.visible):
		$InGameUI.hide()
	elif ($VendorContainer.visible):
		$InGameUI.hide()
	elif ($ArenaMenu.visible):
		$InGameUI.hide()
	else:
		$InGameUI.show()

	if Dialogic.current_timeline == null:
		self.show()
	else:
		self.hide()
