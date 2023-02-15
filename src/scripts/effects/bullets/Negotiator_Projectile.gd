extends RigidBody

var speed = 8
var velocity = Vector3(0,0,0)
onready var projectile_explosion = preload("res://scenes/Effects/ProjectileEffects/BlasterProjectileExplosion.tscn")

func _ready():
	pass

func _physics_process(delta):
	velocity.x = speed * delta * 1
	translate(velocity)



func _on_Area_body_entered(body):
	var explosion = projectile_explosion.instance()
	get_tree().current_scene.add_child(explosion)
	explosion.global_transform = $Explosion.global_transform
	queue_free()
	pass 
