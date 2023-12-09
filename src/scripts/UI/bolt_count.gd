extends Label

func _process(_delta):
	text = format_bolt_amount(Globle.bolts)

func format_bolt_amount(bolts : int) -> String:
	var bolts_string : String = str(bolts)

	# Set the comma to the each 3rd place on the string.
	for c in range(bolts_string.length() -3, 0, -3):
		bolts_string = bolts_string.insert(c, ",")
	return bolts_string
