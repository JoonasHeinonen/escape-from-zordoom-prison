extends KinematicBody

#moving and attack tutorial
#https://www.youtube.com/watch?v=4WywpSBncFI
var motion = Vector3()
var gravity = 0

var direction = 1

var is_moving_left = true

var speed = -90

var target: Player = null

var value  = 0

onready var ray =$Sprite3D/player_finding

var laser_attack_scene = preload("res://scenes/Projectiles/nef_head_laser.tscn")

func _physics_process(delta):
	motion.y = gravity
	
	motion.x = speed * direction
	
	move_and_slide(motion * delta)
	# changes direction 
	for i in get_slide_count():
		var slide_collision = get_slide_collision(i)
		var collider = slide_collision.get_collider()
		if  is_on_wall() :
			#direction=-1
			$AnimationPlayer.play("Enemy_Turn_Right")
			speed *= -1
			value += 1
			ray.set_rotation_degrees(Vector3(0,0,90.237))
		if  is_on_wall() and value == 2:
			$AnimationPlayer.play("Enemy_Turn_Left")
			value = 0
			ray.set_rotation_degrees(Vector3(0,0,-89.21))
						

func _on_player_finding_player_seen():
	var attack = laser_attack_scene.instance()
	add_child(attack)
	attack.global_translation = $laser_muzzle.global_translation
	print("fire laser") 
# TODO fix animation
