extends ProjectileBase
# Make spread move then code hit box.
# https://www.youtube.com/watch?v=2G41KECXXn4
# Look at this for trying to get bullet 1 to move

@onready var projectile_effect = preload("res://scenes/Effects/ProjectileEffects/BlasterProjectileEffect.tscn")
@onready var projectile_explosion = preload("res://scenes/Effects/ProjectileEffects/BlitzGunProjectileExplosion.tscn")

func _ready():
	velocity = Vector3(0, 0, 0)
	speed = 8
	set_physics_process(true)

func _physics_process(delta):
	velocity.x = speed * delta * 1
	translate(velocity)

func _on_BlitzArea_body_entered(body):
	var explosion = projectile_explosion.instantiate()
	get_tree().current_scene.add_child(explosion)
	explosion.global_transform = $Explosion.global_transform
	queue_free()
