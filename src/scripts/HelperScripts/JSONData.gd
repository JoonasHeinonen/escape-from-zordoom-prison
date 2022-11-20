extends Node

var item_data

# Called when the node enters the scene tree for the first time.
func _ready():
	item_data = load_data("res://Data/weapon_data.json")
	for key in item_data.keys():
		item_data[key]["key"] = key
	print(get_item_by_key("blitz_gun"))

# Loads the JSON data.
func load_data(file_path):
	var json_data
	var file_data = File.new()
	
	file_data.open(file_path, File.READ)
	json_data = parse_json(file_data.get_as_text())
	file_data.close()
	return json_data

func get_item_by_key(key):
	if item_data and item_data.has(key):
		return item_data[key].duplicate(true)
