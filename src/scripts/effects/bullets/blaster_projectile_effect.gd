extends KinematicBody

onready var anim_player = $AnimationPlayer

var speed = -1
var velocity = Vector3(0,0,0)

func _physics_process(delta):
	velocity.x = speed * delta * 1
	translate(velocity)
	if $Sprite3D.frame in [0]:
		queue_free()
