extends KinematicBody

func _ready():
	#loads texture through code
	
	pass # Replace with function body.

func _input(event):
	if (Globle.player_character == "Angela"):
		$CharacterSprite_Angela.hide()
	if (Globle.player_character == "Rivet"):
		$CharacterSprite_Rivet.hide()
