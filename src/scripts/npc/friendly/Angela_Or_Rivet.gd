extends KinematicBody
#enter button is all wrong may have to redue it
func _ready():
	
	pass # Replace with function body.

func _input(event):
	if (Globle.player_character == "Angela"):
		$CharacterSprite_Angela.hide()
	if (Globle.player_character == "Rivet"):
		$CharacterSprite_Rivet.hide()
