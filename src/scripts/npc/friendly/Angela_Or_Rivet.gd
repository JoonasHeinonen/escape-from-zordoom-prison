extends KinematicBody
#enter button is all wrong may have to redue it
func _ready():
	
	pass # Replace with function body.

func _input(event):
	if (Globle.player_character == "Angela"):
		$Rivet_sprite.show()
	if (Globle.player_character == "Rivet"):
		$Angela_sprite.show()
