extends KinematicBody

func _input(event):
	if (Globle.player_character == "Angela"):
		$Rivet_sprite.show()
	if (Globle.player_character == "Rivet"):
		$Angela_sprite.show()
