extends Camera3D

var player
var player_camera
var sniping_radical
var sniping_radical_camera

func _ready():
	set_process(true)
	player = get_tree().get_root().get_node("Level/player")
	player_camera = get_parent()
	sniping_radical = get_parent().get_parent().get_node("SnipingRadical")
	sniping_radical_camera = get_parent().get_parent().get_node("SnipingRadical/Node3D/Camera3D")

func _physics_process(_delta):
	if (player.player_health <= 0):
		set_as_top_level(true)
	
	if (player.player_is_aiming_with_rifle):
		var position2D = get_viewport().get_mouse_position()
		var drop_plane : Plane = Plane(Vector3(0, 0, 1), -20)
		var _position3D = drop_plane.intersects_ray(
			self.project_ray_origin(position2D),
			self.project_ray_normal(position2D))
#		sniping_radical.translation = _position3D
#		sniping_radical.translation.z = 0
		self.current = false
		sniping_radical_camera.current = true
	elif (!player.player_is_aiming_with_rifle): 
		self.set_as_top_level(false)
		self.position = Vector3(0, 0, 0)
		self.current = true
		sniping_radical_camera.current = false

func _on_player_update_player_position_to_camera(_new_aiming_radical):
	if (!player.player_is_aiming_with_rifle):
		# Set mouse position.
		get_viewport().warp_mouse(get_viewport().size / 2)
		# Confine the mouse to the center, then unconfine it, it centers the mouse.
		sniping_radical.position = Vector3(0, 0, 0)
		# TODO Initial startup is the issue. Proceed with the gameplay.
