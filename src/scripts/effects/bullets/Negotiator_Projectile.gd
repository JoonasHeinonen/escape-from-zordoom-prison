extends RigidBody

var speed = 8
var velocity = Vector3(0,0,0)
onready var projectile_explosion = preload("res://scenes/Effects/ProjectileEffects/NegotiatorExplosion.tscn")

func _ready():
	$KillTimer.connect("timeout", self, "_on_KillTimer_timeout")
	$KillTimer.start()
	pass

func _physics_process(delta):
	velocity.x = speed * delta * 1
	translate(velocity)

func _on_ProjectileArea_body_entered(body):
	var explosion = projectile_explosion.instance()
	get_tree().current_scene.add_child(explosion)
	explosion.global_transform = $Explosion.global_transform
	queue_free()
	pass # Replace with function body.
