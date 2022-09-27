extends VBoxContainer

onready var level_button = preload("res://scenes/Menu/Materials/MenuButton.tscn")

var levels = []
var unwanted_chars = ["_",".tscn"]

# Called when the node enters the scene tree for the first time.
func _ready():
	levels = list_levels("res://scenes/Levels")
	
	# Iterates through the levels.
	for level_name in levels:
		var level = level_button.instance()
		
		# Takes the chars from the level_name.
		for c in unwanted_chars:
			level_name = level_name.replace(c, " ")
		level_name.erase(level_name.length() - 1, 1)

		level.set_label(level_name)
		self.add_child(level)

# Lists all the levels.
func list_levels(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif file.ends_with(".tscn"):
			files.append(file)

	dir.list_dir_end()

	return files
