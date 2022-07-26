extends KinematicBody

# Initializes the animation state machine.
var state_machine

var velocity = Vector3(0,0,0)
export var speed = 1
var gravity = 0
var jump = 5
var bolt = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
	
	var current = state_machine.get_current_node()
	
	if Input.is_action_pressed("ui_right") and  Input.is_action_pressed("ui_left"):
		state_machine.travel("Angela_Still")		
		velocity.x = 0
	elif Input.is_action_pressed("ui_right"):
		state_machine.travel("Angela_Walk")		
		velocity.x = 5
		$Sprite3D.scale.x = 1
	elif Input.is_action_pressed("ui_left"):
		state_machine.travel("Angela_Walk")		
		velocity.x = -5
		$Sprite3D.scale.x = -1
	else:
		velocity.x = lerp(velocity.x,0,0.1)
		state_machine.travel("Angela_Still")
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump

	move_and_slide(velocity,Vector3.UP)
