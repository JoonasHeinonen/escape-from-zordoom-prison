extends RigidBody

onready var projectile_effect 				= preload("res://scenes/Effects/ProjectileEffects/BlasterProjectileEffect.tscn")
onready var blaster_projectile_explosion 	= preload("res://scenes/Effects/ProjectileEffects/BlasterProjectileExplosion.tscn")
onready var miniturret_projectile_explosion = preload("res://scenes/Effects/ProjectileEffects/MiniturretProjectileExplosion.tscn")

var speed = 8
var velocity = Vector3(0, 0, 0)

export (String, "blaster", "miniturret") var weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	$KillTimer.connect("timeout", self, "_on_KillTimer_timeout")
	$KillTimer.start()

	# Set the combustion effect, if the projectile is blaster.
	if (weapon == "blaster"):
		$CombustionTimer.connect("timeout", self, "_on_CombustionTimer_timeout")
		$CombustionTimer.start()
		effect()

func _physics_process(delta):
	velocity.x = speed * delta * 1
	translate(velocity)

func _on_Area_body_entered(body):
	match (weapon):
		"blaster":
			var explosion = blaster_projectile_explosion.instance()
			get_tree().current_scene.add_child(explosion)
			explosion.global_transform = $Explosion.global_transform
			explosion.rotation = Vector3.ZERO
			queue_free()
		"miniturret":
			var explosion = miniturret_projectile_explosion.instance()
			get_tree().current_scene.add_child(explosion)
			explosion.global_transform = $Explosion.global_transform
			explosion.rotation = Vector3.ZERO
			queue_free()

# Run when KillTimer has timed out.
func _on_KillTimer_timeout():
	queue_free()

# Run when CombustionTimer has timed out.
func _on_CombustionTimer_timeout():
	effect()
	$CombustionTimer.start()

# Emits the combustion of the blaster projectile.
func effect():
	var eff = projectile_effect.instance()
	eff.translation.x = 3
	$Combustion.add_child(eff)
	eff.global_transform = $Combustion.global_transform
