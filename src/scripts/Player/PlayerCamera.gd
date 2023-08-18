extends Camera

var player
var player_camera
var sniping_radical
var sniping_radical_camera

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	player = get_parent().get_parent()
	player_camera = get_parent()
	sniping_radical = get_parent().get_parent().get_node("SnipingRadical")
	sniping_radical_camera = get_parent().get_parent().get_node("SnipingRadical/Spatial/Camera")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Stops following the player once the player's dead.
	if (player.player_health <= 0) : self.set_as_toplevel(true)

	# Also, temporarily stop following player if taking aim with the pulse rifle.
	if (player.player_is_aiming_with_rifle):
		## https://www.youtube.com/watch?v=t_kfgDDJg10&ab_channel=JohnnyRouddro
		var position2D = get_viewport().get_mouse_position()
		var drop_plane : Plane = Plane(Vector3(
				0, 
				0, 
				1
			), -20)
		var position3D = drop_plane.intersects_ray(
			self.project_ray_origin(position2D),
			self.project_ray_normal(position2D))
		sniping_radical.translation = Vector3(player.translation.x, player.translation.y, 0)
		sniping_radical.translation = position3D
		sniping_radical.translation.z = 0
		self.current = false
		sniping_radical_camera.current = true
	elif (!player.player_is_aiming_with_rifle): 
		self.set_as_toplevel(false)
		self.translation = Vector3(0, 0, 0)
		self.current = true
		sniping_radical_camera.current = false
	#print(sniping_radical.translation)
