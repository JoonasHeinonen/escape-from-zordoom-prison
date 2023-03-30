extends Particles

onready var expire_timer = $ExpireTimer
onready var player 		 = get_parent().get_parent()

var parent 				 = null

# Called when the node enters the scene tree for the first time.
func _ready():
	player.health_node_counter += 1
	expire_timer.connect("timeout", self, "_on_ExpireTimer_timeout")
	parent = self.get_parent().get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.global_transform = parent.global_transform

# Removes the node effect.
func _on_ExpireTimer_timeout():
	self.queue_free()
