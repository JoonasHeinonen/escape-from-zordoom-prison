extends KinematicBody

#moving and attack tutorial
#https://www.youtube.com/watch?v=4WywpSBncFI
var motion = Vector3()
var gravity = 0

var direction = 1

var is_moving_left = true

var speed = -90

var target: Player = null

# to do : make it so that when it hits a wall it changes direction
#right
#to do make it so that when it hits a wall on its left it turns right

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
		

#func _on_RayCast_my_signal():
	#speed *= -1
	#pass # Replace with function body.
