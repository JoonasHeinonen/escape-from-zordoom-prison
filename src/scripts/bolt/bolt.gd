extends Area

var getMagnet=false
#var position=Vector3()

#adding random number
var random=RandomNumberGenerator.new()

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
			
				queue_free()
			
	

