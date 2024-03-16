extends TransportNode

class_name Taxi

@export var waypoints = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for waypoint in waypoints:
		print(waypoint)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
