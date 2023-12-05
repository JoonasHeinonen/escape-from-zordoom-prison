extends Control

onready var boss_health_bar = $UIBossData/UIBossDataCenterContainer/CenterContainer/BossHealthBar
onready var boss_health_percentage = $UIBossData/UIBossDataCenterContainer/CenterContainer/BossHealthPercentage
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
	boss_health_percentage.margin_left = 387
	boss_health_percentage.margin_top = 20
	boss_health_percentage.margin_right = 246
	boss_health_percentage.margin_bottom = 20
	boss_health_bar.margin_left = 12
	boss_health_bar.margin_top = 55
	boss_health_bar.margin_right = 418
	boss_health_bar.margin_bottom = 77
	boss_health_bar.rect_size = Vector2(406, 22)

	if ($InventoryContainer.visible):
		$InGameUI.hide()
	elif ($PauseMenuContainer.visible):
		$InGameUI.hide()
	elif ($VendorContainer.visible):
		$InGameUI.hide()
	else:
		$InGameUI.show()
