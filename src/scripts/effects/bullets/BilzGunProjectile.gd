extends RigidBody
#make spread move then code hit box
#https://www.youtube.com/watch?v=2G41KECXXn4
#look at this for trying to get bullet 1 to move
var speed = 8
var velocity = Vector3(0,0,0)

onready var projectile_effect = preload("res://scenes/Effects/ProjectileEffects/BlasterProjectileEffect.tscn")
onready var projectile_explosion = preload("res://scenes/Effects/ProjectileEffects/BlizGunProjectileExplosion.tscn")

func _ready():
	$KillTimer.connect("timeout", self, "_on_KillTimer_timeout")
	$KillTimer.start()
	set_physics_process(true)
	pass 

func _physics_process(delta):
	velocity.x = speed * delta * 1
	translate(velocity)


func _on_BiltzArea_body_entered(body):
	var explosion = projectile_explosion.instance()
	get_tree().current_scene.add_child(explosion)
	explosion.global_transform = $Explosion.global_transform
	queue_free()
	pass # Replace with function body.
