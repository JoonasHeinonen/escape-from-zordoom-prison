extends GPUParticles3D

var pm : ParticleProcessMaterial = process_material

func _process(delta):
	pm.color.a -= delta * 1.0
	if pm.color.a < 0.0:
		pm.color.a = 0.0
	print(pm.color.a)
	# Control the fade of the sprite but only can happen once.
