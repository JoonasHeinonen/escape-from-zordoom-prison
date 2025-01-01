extends CharacterBody3D

class_name Taxi

@export var waypoints_node : Node
var waypoint_positions : Array = []
var waypoints : Array = []
var active_waypoint : Node = null
var waypoint_index = 0
var number_of_waypoints = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if waypoints_node != null:
		for waypoint in waypoints_node.get_children():
			var waypoint_position = Vector3(waypoint.position.x, waypoint.position.y, 0)
			waypoints.append(waypoint)
			waypoint_positions.append(waypoint_position)
	number_of_waypoints = waypoints.size() - 1
	active_waypoint = waypoints[waypoint_index]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Vector3(3, 0, 0)
	# https://www.reddit.com/r/godot/comments/o6vgq5/how_to_make_an_object_move_towards_another_3d/
	#  var normal_to_planet = (planet_position - moon_position).normalized()
	active_waypoint.waypoint_active = true
	position = position.move_toward(active_waypoint.position, delta*2)

func _on_activation_area_area_entered(area):
	if (area.name == "WaypointDetectionArea"):
		if (area.get_parent().name == active_waypoint.name):
			if (waypoint_index == number_of_waypoints):
				waypoint_index = -1
				waypoints[0].waypoint_active = true
			waypoint_index = waypoint_index + 1
			waypoints[waypoint_index - 1].waypoint_active = false
			active_waypoint = waypoints[waypoint_index]
