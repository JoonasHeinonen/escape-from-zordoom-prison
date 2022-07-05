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
		
		print(translation)
	var bodies=get_overlapping_areas()
	for body in bodies:
		if body.name=="AreaPlayer":
			getMagnet=true
			translation +=(get_parent().get_node("player").translation-translation)/10
			
	
