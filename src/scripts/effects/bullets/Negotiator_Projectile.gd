extends ProjectileBase

@onready var projectile_explosion = preload("res://scenes/Effects/ProjectileEffects/NegotiatorExplosion.tscn")

func _ready():
	velocity = Vector3(0, 0, 0)

func _physics_process(delta):
	speed = 16
	velocity.x = speed * delta * 1
	translate(velocity)

func _on_ProjectileArea_body_entered(body):
	var explosion = projectile_explosion.instantiate()
	get_tree().current_scene.add_child(explosion)
	explosion.global_transform = $Explosion.global_transform
	queue_free()
