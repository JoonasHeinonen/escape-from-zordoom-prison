extends Camera

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	player = get_parent().get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Stops following the player once the player's dead.
	if (!player.alive) : self.set_as_toplevel(true)