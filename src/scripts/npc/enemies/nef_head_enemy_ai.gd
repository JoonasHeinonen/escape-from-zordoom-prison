extends KinematicBody

var speed =-50
var motion = Vector3()
var gravity = -5

var direction = 1

func _ready():
	pass
#https://www.youtube.com/watch?v=WJfjnwxM0Do
# youtube video to do basic movement through code
#https://www.youtube.com/watch?v=ROYG4widsXc
#basic movement through code
# tell the dif btween the floor and a wall
func _physics_process(delta):
	motion.y = gravity
	
	motion.x = speed * direction
	var bad_guy_postion = global_translation
	move_and_slide(motion * delta)
	#global_translation.distance_to(bad_guy_postion)
	#if global_translation.distance_to(bad_guy_postion) < 1 * delta:
		#direction = direction * -1
	#if is_on_wall():
		#direction = direction * -1
