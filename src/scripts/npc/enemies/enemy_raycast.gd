extends RayCast3D

var enemy

func _ready():
	enemy = get_parent() 

func _physics_process(delta: float):
	if is_colliding() && get_collider().name == "player": enemy.is_alerted = true
