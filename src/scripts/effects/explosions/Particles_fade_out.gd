extends Particles

var pm : ParticlesMaterial=process_material
func _process(delta):
	var pm : ParticlesMaterial=process_material
	pm.color.a-=delta
	if pm.color.a<0.0:
		pm.color.a=0.0 
	#control the fade of the sprite but only can happen once.
	#maybe try and get a tween to work
	pass
	
func _ready():
	pass
