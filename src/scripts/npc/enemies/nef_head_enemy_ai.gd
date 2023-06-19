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

onready var ray =$Sprite3D/RayCast
#to do: when player is on the bad guy it freaks out
#to do: have it so that the ray cast is fliped
func _physics_process(delta):
	motion.y = gravity
	
	motion.x = speed * direction
	
	var bad_guy_postion = global_translation
	move_and_slide(motion * delta)
	
	# this makes it so that when the nef_head hits a wall and for some resaon it also sees the player as a wall it 
	# changes direction 
	for i in get_slide_count():
		var slide_collision = get_slide_collision(i)
		var collider = slide_collision.get_collider()
		#if collider is Player:
			# speed *= -1
			 #print ("hit the player")
		if  is_on_wall() :
			#direction=-1
			$AnimationPlayer.play("Enemy_Turn_Right")
			speed *= -1
			value += 1
			print(ray.translation.x)
			ray.set_rotation_degrees(Vector3(0,0,90.237))
		if  is_on_wall() and value == 2:
			$AnimationPlayer.play("Enemy_Turn_Left")
			value = 0
			ray.set_rotation_degrees(Vector3(0,0,-89.21))
			
#func _on_RayCast_my_signal():
	#speed *= -1
	#pass # Replace with function body.
