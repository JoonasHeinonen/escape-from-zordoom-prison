extends StaticBody

export(String, "First", "Second") var teleport_index

var player_in_teleport_radius : bool = false

var target_teleport : String

var player
var target_teleport_location

func _ready():
	define_target_teleport()
	for c in get_parent().get_children():
		if c.name == target_teleport:
			target_teleport_location = Vector3(c.translation.x, c.translation.y + 0.3, 0)

func _process(delta):
	if (player_in_teleport_radius and Input.is_action_just_pressed("ui_accept")):
		teleport_player()

func define_target_teleport():
	var target_teleport_index
	var cleaned_name := self.name
	cleaned_name = cleaned_name.left(cleaned_name.length() - 1)

	match teleport_index:
		"First":
			target_teleport_index = int(self.name[-1]) + 1
		"Second":
			target_teleport_index = int(self.name[-1]) - 1
	target_teleport = cleaned_name + str(target_teleport_index)

func teleport_player():
	if (!player.boss_fight_active):
		player.translation = target_teleport_location

func _on_TeleportationArea_body_entered(body):
	if body.name == "player":
		player_in_teleport_radius = true
		player = body

func _on_TeleportationArea_body_exited(body):
	if body.name == "player":
		player_in_teleport_radius = false
		player = null
