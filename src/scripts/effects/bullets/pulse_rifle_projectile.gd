extends ProjectileBase

@onready var blaster_projectile_explosion = preload("res://scenes/Effects/ProjectileEffects/BlasterProjectileExplosion.tscn")

func _ready():
	velocity = Vector3(0, 0, 0)
	speed = 50
	$KillTimer.connect("timeout", Callable(self, "_on_KillTimer_timeout"))
	$KillTimer.start()

func _physics_process(delta):
	velocity.x = speed * delta * 1
	translate(velocity)

func _on_KillTimer_timeout():
	queue_free()

func _on_PulseProjectileArea_body_entered(body):
	var explosion = blaster_projectile_explosion.instantiate()
	get_tree().current_scene.add_child(explosion)
	explosion.global_transform = $Explosion.global_transform
	queue_free()
