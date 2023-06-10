extends KinematicBody

#moving and attack tutorial
#https://www.youtube.com/watch?v=4WywpSBncFI
var speed =-50
var motion = Vector3()
var gravity = -1

var direction = 1

var is_moving_left = true

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

