extends RigidBody

var velocity = Vector3(1, -1, 0)
#https://www.youtube.com/watch?v=p6OQ7XVsiKw
onready var gravity_bomb_explosion = preload("res://scenes/Effects/ProjectileEffects/GravityBombExplosion.tscn")
func _ready():
	$KillTimer.connect("timeout", self, "_on_KillTimer_timeout")
	$KillTimer.start()
	apply_impulse(Vector3.ZERO,velocity * 8)

#https://www.youtube.com/watch?v=F1Fyj3Lh_Pc&t=239s
#Explosition effects
func _on_GravityBombArea_body_entered(body):
	var explosion = gravity_bomb_explosion.instance()
	explosion.get_node("KinematicBody/Particles").pm.color.a = 1.0
	get_tree().current_scene.add_child(explosion)
	explosion.global_transform = $Explosion.global_transform
	queue_free()