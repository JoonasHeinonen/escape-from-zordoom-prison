extends RigidBody

var speed = 5
var velocity = Vector3(0, 0, 0)

func _physics_process(delta):
	velocity.x = speed * delta * 1
	translate(velocity)

func set_particle_size(s : float):
	self.scale = Vector3(s, s, 1)

func _on_ProjectileArea_body_entered(body):
	self.queue_free()

func _on_KillTimer_timeout():
	self.queue_free()
