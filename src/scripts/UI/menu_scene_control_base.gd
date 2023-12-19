extends Control

class_name MenuSceneControlBase

@export_enum("Full alignment", "Horizontal alignment", "Vertical alignment") var alignment: String

var rect_size_x = self.size.x
var rect_size_y = self.size.y

var time_scale_target = 1.0
var interpolation = 1.0

func _process(delta):
	match alignment:
		"Full alignment":
			self.size = Vector2(
				get_viewport().size.x,
				get_viewport().size.y
			)
		"Horizontal alignment":
			self.size = Vector2(
				rect_size_x,
				get_viewport().size.y
			)
		"Vertical alignment":
			self.size = Vector2(
				get_viewport().size.x,
				rect_size_y
			)
		_:
			self.size = Vector2(
				rect_size_x,
				rect_size_y
			)
