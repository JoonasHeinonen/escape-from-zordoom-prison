extends Node
#have to autoload the script in the project to get the globle script to work
#source: https://www.youtube.com/watch?v=6e9I_e8aHD4
var bolts=0
#not sure if we need this instance_node
func instance_node(node,location,parent):
	var node_instance=node.instance()
	parent.add_child(node_instance)
	node_instance.global_position=location
	return node_instance
