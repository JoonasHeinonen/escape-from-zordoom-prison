extends RigidBody

onready var countdown = $Timer.time_left

var state_machine

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	$Timer.connect("timeout", self, "_on_Timer_timeout")

# Detects the collisions on this scene.
func _on_Area_area_entered(body):
	if body.name == "ProjectileExplosionArea":
		state_machine.travel("Activated")
		$Timer.start()

# Timer timeout.
func _on_Timer_timeout():
	countdown -= 1
	if countdown <= 0:
		queue_free()
