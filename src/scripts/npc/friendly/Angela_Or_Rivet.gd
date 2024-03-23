extends CharacterBody3D

func _input(_event):
	if (Globle.player_character == "Angela"):
		$Rivet_sprite.show()
	if (Globle.player_character == "Rivet"):
		$Angela_sprite.show()
