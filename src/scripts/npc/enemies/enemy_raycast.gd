extends RayCast

var enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy = get_parent() 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	if is_colliding() && get_collider().name == "player": enemy.alerted = true
