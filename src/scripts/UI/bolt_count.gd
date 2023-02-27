extends Label

# Displays the amout on the player screen.
func _process(delta):
	text = format_bolt_amount(Globle.bolts)

# Format bolts in a correct manner.
func format_bolt_amount(bolts : int) -> String:
	var str_bolts : String = str(bolts)

	# Set the comma to the each 3rd place on the string.
	for c in range(str_bolts.length() -3, 0, -3):
		str_bolts = str_bolts.insert(c, ",")
	return str_bolts
