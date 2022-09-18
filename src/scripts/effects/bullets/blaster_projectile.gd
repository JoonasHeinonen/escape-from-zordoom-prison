extends KinematicBody

onready var projectile_effect = preload("res://scenes/Effects/ProjectileEffects/BlasterProjectileEffect.tscn")

var speed = 8
var velocity = Vector3(0,0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	$KillTimer.connect("timeout", self, "_on_KillTimer_timeout")
	$KillTimer.start()
	$CombustionTimer.connect("timeout", self, "_on_CombustionTimer_timeout")
	$CombustionTimer.start()
	effect()	

func _physics_process(delta):
	velocity.x = speed * delta * 1
	translate(velocity)

# Run when KillTimer has timed out.
func _on_KillTimer_timeout():
	print("Killed the object!")
	queue_free()

# Run when CombustionTimer has timed out.
func _on_CombustionTimer_timeout():
	print("Emitting gas!")
	effect()
	$CombustionTimer.start()

# Emits the combustion of the blaster projectile.
func effect():
	var eff = projectile_effect.instance()
	eff.translation.x = 3
	$Combustion.add_child(eff)
	eff.global_transform = $Combustion.global_transform
