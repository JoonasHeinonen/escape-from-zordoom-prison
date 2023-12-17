extends Control

class_name MenuSceneControlBase

export (String, "Full alignment", "Horizontal alignment", "Vertical alignment") var alignment

var rect_size_x = self.rect_size.x
var rect_size_y = self.rect_size.y

var time_scale_target = 1
var interpolation = 1

func _process(delta):
	match alignment:
		"Full alignment":
			self.rect_size = Vector2(
				get_viewport().size.x,
				get_viewport().size.y
			)
		"Horizontal alignment":
			self.rect_size = Vector2(
				rect_size_x,
				get_viewport().size.y
			)
		"Vertical alignment":
			self.rect_size = Vector2(
				get_viewport().size.x,
				rect_size_y
			)
		_:
			self.rect_size = Vector2(
				rect_size_x,
				rect_size_y
			)
