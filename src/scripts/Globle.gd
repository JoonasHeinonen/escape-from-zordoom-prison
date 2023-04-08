extends Node
#have to autoload the script in the project to get the globle script to work
#source: https://www.youtube.com/watch?v=6e9I_e8aHD4

# 3-dimensional array containing all the necessary data for each weapon.
# Subarray 0: Weapon names & identifiers.
# Subarray 1: Weapon prices.
# Subarray 2: Weapon descriptions for the vendor.
const WPNS = [
	[
		"edge_blaster", "blitz_gun", "gravity_bomb", "negotiator",
		"pulse_rifle", "ry3no", "sheepinator"
	],
	[
		1500, 5000, 8000, 12000, 25000, 100000, 100000
	],
	[
		"Edge Blaster is Angela's personal favorite.",
		"The Blitz Gun is a small blue and silver shotgun with a large irregular hexgonal barrel and a lower muzzle beneath it. It also features an orange targeting computer above the muzzle and a left-hand grip at the back. It fires scatter shots followed by arcs of lightning.",
		"Both the Gravity Bomb and Mini-Nuke are long, blue grenade launchers with cooling vents and glowing yellow generator at the back, and two flaps (four as Mini-Nuke) at the end of the nozzle. The generator features tubes leading from it to the launcher of the weapon. Both feature a left-hand grip at the bottom.",
		"The Negotiator is a shoulder-mounted yellow and grey rocket launcher with red highlights. It features two rockets at the end from which it fires, and one left-hand grip. The rockets it fired would fly towards enemies in a spiraling motion.",
		"The Pulse Rifle is a green and silver sniper rifle. It has a long barrel, a green scope and a left-hand grip. When fired, it fires a single bullet leaving a long green trail, and the barrel of the weapon moved backwards to compensate the recoil.",
		"The RY3NO is a brown weapon with an large and thick barrel. It contains six protruding spikes surrounding its main nozzle, and has a left-hand grip. The RYNOCIRATOR appears very similar, though both the barrel, stock, and the spikes have gained an extra layer of armor, and the nozzle is smaller as well.",
		"The Sheepinator in Going Commando is a black pistol with glowing orange accents. It fires two spiralling orange beams which function as a single beam. The Black Sheepinator is a longer carbine, with greater orange accents and a left-hand grip."
	]
]

var player_character 	= "Angela"

var bolts 			 	= 0

var weapons_for_sale 	= [
	"edge_blaster", "blitz_gun", "gravity_bomb", "negotiator", "pulse_rifle", "ry3no", "sheepinator"
]
var current_weapons  	= ["edge_blaster", "gravity_bomb" , "negotiator"]

var player_inventory 	= false
var vendor_open 	 	= false
var vendor_active 	 	= false
var melee_attack 		= false

var menu_to_return 		= "none"

#spawn_point

var spawn_point = Vector3(0, 0, 0)
#todo redue the global spelling
func update_spawn(new_point):
	spawn_point=new_point
	print(spawn_point)
	
# Not sure if we need this instance_node
func instance_node(node,location,parent):
	var node_instance=node.instance()
	parent.add_child(node_instance)
	node_instance.global_position=location
	return node_instance

# Updates the vendor after purchasing an item.
func update_vendor():
	var wpn_index : int = -1
	for wpn_for_sale in weapons_for_sale:
		wpn_index += 1
		if current_weapons.has(wpn_for_sale):
			weapons_for_sale.remove(wpn_index)
