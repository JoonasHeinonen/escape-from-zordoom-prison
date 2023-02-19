extends Area

# var position 		= Vector3()

var getMagnet 		= false
var random 	  		= RandomNumberGenerator.new() # Adding random number.
var bolt_image_path = "res://resources/images/collectibles/bolt_"

# Called when the node enters the scene tree for the first time.
func _ready():
	random.randomize()
	var bolt_index = str(random.randi_range(0,2))
	var bolt_file_name = bolt_index + ".png"
	var resource = null
	
	match bolt_index:
		"0":
			resource = load(bolt_image_path + bolt_file_name)
			$Sprite3D.set_texture(resource)
		"1":
			resource = load(bolt_image_path + bolt_file_name)
			$Sprite3D.set_texture(resource)
		"2":
			resource = load(bolt_image_path + bolt_file_name)
			$Sprite3D.set_texture(resource)

func _physics_process(delta):
	if getMagnet == false:
		#makes the bolts fall due to the y axis
		translation.y
		
	var bodies=get_overlapping_areas()
	for body in bodies:
		if body.name=="AreaPlayer":
			getMagnet=true
			translation +=(get_parent().get_node("player").translation-translation)/10
		var bodies2=get_overlapping_bodies()
		for bod in bodies2:
			#this add the bolt amount to the player
			
			if bod.name=="player":
				#makes sure that every number is random
				random.randomize()
				var countBoults=get_parent().get_node("player").bolt+random.randi_range(10,100)
				#grabes the bolt amout
				Globle.bolts+=countBoults
				# print(Globle.bolts)
				
				# Plays the bolt sound on the player's instance.
				if bod.has_method("collect_bolt"):
					bod.collect_bolt(random.randi_range(0,2))
				queue_free()
			
	

