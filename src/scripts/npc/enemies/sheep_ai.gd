extends EnemyBase

var vel : int = 3

func _ready():
	if (direction == "Left"):
		$EnemySprite.scale.x = -4
		velocity.x = vel
		direction = "Right"
	elif (direction == "Right"):
		$EnemySprite.scale.x = 4
		velocity.x -= vel
		direction = "Left"
	element = elements.GROUND

func _physics_process(delta):
	determine_element(element, delta)
	determine_stance("Patrol", vel)

func _on_jump_timer_timeout():
	velocity.y = 2
