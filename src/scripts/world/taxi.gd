extends CharacterBody3D

class_name Taxi

@export var waypoints_node : Node
var waypoint_positions : Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	if waypoints_node != null:
		for waypoint in waypoints_node.get_children():
			print("Or this?")
			var waypoint_position = Vector3(waypoint.position.x, waypoint.position.y, 0)
			waypoint_positions.append(waypoint_position)
	print("Does this get printed?")
	for waypoint_position in waypoint_positions:
		print("Position: ", waypoint_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Vector3(3, 0, 0)
	set_velocity(velocity)
	move_and_slide()
