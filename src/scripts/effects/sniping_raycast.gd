extends RayCast

class_name SnipingRayCast

onready var beam_mesh = $SnipingMeshInstance

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var cast_point
	force_raycast_update()

	if is_colliding():
		cast_point = to_local(get_collision_point())

		beam_mesh.mesh.height = cast_point.y
		beam_mesh.translation.y = cast_point.y / 2
