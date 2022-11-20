extends Node
#have to autoload the script in the project to get the globle script to work
#source: https://www.youtube.com/watch?v=6e9I_e8aHD4

const WEAPONS_AVAILABLE   = [
	"edge_blaster", "blitz_gun", "gravity_bomb", "negotiator",
	"pulse_rifle", "ry3no", "sheepinator"
]

var bolts 			= 0
var current_weapons = ["edge_blaster"]

#not sure if we need this instance_node
func instance_node(node,location,parent):
	var node_instance=node.instance()
	parent.add_child(node_instance)
	node_instance.global_position=location
	return node_instance
