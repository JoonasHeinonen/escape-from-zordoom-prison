extends KinematicBody

#moving and attack tutorial
#https://www.youtube.com/watch?v=4WywpSBncFI
var motion = Vector3()
var gravity = -1

var direction = 1

var is_moving_left = true

var speed = -50

var target: Player = null

# to do : make it so that when it hits a wall it changes direction
func _ready():
	pass


func _physics_process(delta):
	motion.y = gravity
	
	motion.x = speed * direction
	
	var bad_guy_postion = global_translation
	move_and_slide(motion * delta)
	
	# this makes it so that when the nef_head hits the player it 
	# changes direction 
	for i in get_slide_count():
		var slide_collision = get_slide_collision(i)
		var collider = slide_collision.get_collider()
		if collider is Player:
			 speed *= -1
			 print ("hit the player")
		elif  is_on_wall() :
			direction=-1
			#speed *= -1
			print (is_on_wall())
			
#func wall_Turn_around():
	#for i in get_slide_count():
		#var slide_collision = get_slide_collision(i)
		#var collider = slide_collision.get_collider()
		#if is_on_wall():
			 #speed *= -1
			 #print ("hit the wall")
			 #print(speed)

#func _on_RayCast_my_signal():
	#speed *= -1
	#pass # Replace with function body.
