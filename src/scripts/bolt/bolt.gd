extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var getMagnet=false
#var position=Vector3()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	if getMagnet == false:
		#makes the bolts fall due to the y axis
		translation.y
		#print(translation)
	var bodies=get_overlapping_areas()
	for body in bodies:
		if body.name=="AreaPlayer":
			getMagnet=true
			translation +=(get_parent().get_node("player").translation-translation)/10
		var bodies2=get_overlapping_bodies()
		for bod in bodies2:
			#this add the bolt amount to the player
			if bod.name=="player":
				get_parent().get_node("player").score+=1
				print(get_parent().get_node("player").score)
				queue_free()
			
	
