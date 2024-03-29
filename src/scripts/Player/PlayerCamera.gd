extends Camera

var player
var player_camera
var sniping_radical
var sniping_radical_camera

func _ready():
	set_process(true)
	player = get_parent().get_parent()
	player_camera = get_parent()
	sniping_radical = get_parent().get_parent().get_node("SnipingRadical")
	sniping_radical_camera = get_parent().get_parent().get_node("SnipingRadical/Spatial/Camera")

func _physics_process(delta):
	if (player.player_health <= 0) : self.set_as_toplevel(true)
	
	if (player.player_is_aiming_with_rifle):
		var position2D = get_viewport().get_mouse_position()
		var drop_plane : Plane = Plane(Vector3(0, 0, 1), -20)
		var position3D = drop_plane.intersects_ray(
			self.project_ray_origin(position2D),
			self.project_ray_normal(position2D))
#		sniping_radical.translation = position3D
#		sniping_radical.translation.z = 0
		self.current = false
		sniping_radical_camera.current = true
	elif (!player.player_is_aiming_with_rifle): 
		self.set_as_toplevel(false)
		self.translation = Vector3(0, 0, 0)
		self.current = true
		sniping_radical_camera.current = false

func _on_player_update_player_position_to_camera(new_aiming_radical):
	if (!player.player_is_aiming_with_rifle):
		print(get_viewport().size / 2)
		# Set mouse position.
		get_viewport().warp_mouse(get_viewport().size / 2)
		# Confine the mouse to the center, then unconfine it, it centers the mouse.
		sniping_radical.translation = Vector3(0, 0, 0)
		# TODO Initial startup is the issue. Proceed with the gameplay.
