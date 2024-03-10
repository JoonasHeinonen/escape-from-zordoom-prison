extends ProjectileBase

@onready var gravity_bomb_explosion = preload("res://scenes/Effects/ProjectileEffects/GravityBombExplosion.tscn")
@onready var minigun_turret = preload("res://scenes/NPC/Friendly/miniturret.tscn")

@export_enum ("gravity_bomb_projectile", "miniturret_projectile") var projectile_type : String

# https://www.youtube.com/watch?v=p6OQ7XVsiKw
func _ready():
	velocity = Vector3(1, -1, 0)
	apply_impulse(velocity * 8, Vector3.ZERO)

#https://www.youtube.com/watch?v=F1Fyj3Lh_Pc&t=239s
func _on_GravityBombArea_body_entered(body):
	match (projectile_type):
		"gravity_bomb_projectile":
			var explosion = gravity_bomb_explosion.instantiate()
			explosion.get_node("CharacterBody3D/Particles").pm.color.a = 1.0
			get_tree().current_scene.add_child(explosion)
			explosion.global_transform = $Explosion.global_transform
		"miniturret_projectile":
			var m_t = minigun_turret.instantiate()
			get_tree().current_scene.add_child(m_t)
			m_t.global_transform = self.global_transform
	queue_free()
