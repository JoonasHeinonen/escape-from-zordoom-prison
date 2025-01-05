extends Node

class_name GameplayElem

@export_enum("swingshot_orb") var gameplay_elem_type: String

func _ready():
	self.set_meta("type", gameplay_elem_type)
	print(self.get_meta("type"))
