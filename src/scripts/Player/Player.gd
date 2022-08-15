extends KinematicBody

# Initializes the animation state machine.
var state_machine

var velocity = Vector3(0,0,0)
export var speed = 1
var gravity = 4
var jump = 3
var bolt = 0
var alive = true
var on_inventory = false

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
	var current = state_machine.get_current_node()
	
	if alive == true && on_inventory == false:
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
		if is_on_floor() and Input.is_action_just_pressed("jump"):
			velocity.y = jump
		if Input.is_action_just_released("ui_home"):
			on_inventory = true
	elif on_inventory == true:
		if Input.is_action_just_released("ui_home"):
			on_inventory = false
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		state_machine.travel("Angela_Fall")

	move_and_slide(velocity,Vector3.UP)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var y_position = self.global_transform.origin.y
	
	# Fall death.
	if y_position < -3:
		alive = false
		
	# Inventory functionalities.
	if on_inventory:
		velocity.x = 0
		state_machine.travel("Angela_Still")
		$PlayerUI/InventoryContainer.visible = true
	else:
		$PlayerUI/InventoryContainer.visible = false
