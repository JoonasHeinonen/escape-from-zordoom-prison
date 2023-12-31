extends ProjectileBase

@onready var blaster_projectile_explosion = preload("res://scenes/Effects/ProjectileEffects/BlasterProjectileExplosion.tscn")
@onready var miniturret_projectile_explosion = preload("res://scenes/Effects/ProjectileEffects/MiniturretProjectileExplosion.tscn")
@onready var projectile_effect = preload("res://scenes/Effects/ProjectileEffects/BlasterProjectileEffect.tscn")

@export_enum ( "blaster", "miniturret") var weapon : String

func _ready():
	velocity = Vector3(0, 0, 0)
	speed = 8

	if (weapon == "blaster"):
		$CombustionTimer.connect("timeout", Callable(self, "_on_CombustionTimer_timeout"))
		$CombustionTimer.start()
		emit_blaster_combustion_effect()

func _physics_process(delta):
	velocity.x = speed * delta * 1
	translate(velocity)

func _on_Area_body_entered(body):
	match (weapon):
		"blaster":
			var explosion = blaster_projectile_explosion.instantiate()
			get_tree().current_scene.add_child(explosion)
			explosion.global_transform = $Explosion.global_transform
			explosion.rotation = Vector3.ZERO
			queue_free()
		"miniturret":
			var explosion = miniturret_projectile_explosion.instantiate()
			get_tree().current_scene.add_child(explosion)
			explosion.global_transform = $Explosion.global_transform
			explosion.rotation = Vector3.ZERO
			queue_free()

func _on_CombustionTimer_timeout():
	emit_blaster_combustion_effect()
	$CombustionTimer.start()

func emit_blaster_combustion_effect():
	var eff = projectile_effect.instantiate()
	eff.position.x = 3
	$Combustion.add_child(eff)
	eff.global_transform = $Combustion.global_transform
