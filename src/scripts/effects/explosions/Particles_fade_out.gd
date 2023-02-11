extends Particles

var pm : ParticlesMaterial=process_material

func _process(delta):
	var pm : ParticlesMaterial=process_material
	pm.color.a-=delta*1.0
	if pm.color.a<0.0:
		pm.color.a=0.0
	print(pm.color.a)
	#control the fade of the sprite but only can happen once.
	
func _ready():
	pass
