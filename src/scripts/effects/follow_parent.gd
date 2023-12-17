extends GPUParticles3D

@onready var expire_timer = $ExpireTimer
@onready var player = get_parent().get_parent()

var parent = null

func _ready():
	$Audio/HealthNode.play()
	player.health_node_counter += 1
	expire_timer.connect("timeout", Callable(self, "_on_ExpireTimer_timeout"))
	parent = self.get_parent().get_parent()

func _process(_delta):
	self.global_transform = parent.global_transform

func _on_ExpireTimer_timeout():
	self.queue_free()
