extends KinematicBody



var velocity=Vector3(0,0,0)
export var  speed=1
var gravity=0
var jump=5
var bolt=0

func _physics_process(delta):
	if Input.is_action_pressed("ui_right") and  Input.is_action_pressed("ui_left"):
		velocity.x=0
	elif Input.is_action_pressed("ui_right"):
		velocity.x=5
	elif Input.is_action_pressed("ui_left"):
		velocity.x=-5
	else:
		velocity.x=lerp(velocity.x,0,0.1)
	
	
	if not is_on_floor():
		velocity.y-=gravity*delta
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		
		velocity.y=jump
	
	
	move_and_slide(velocity,Vector3.UP)
