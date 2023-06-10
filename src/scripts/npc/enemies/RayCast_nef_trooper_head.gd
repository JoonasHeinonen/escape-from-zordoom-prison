extends RayCast

var target: Player = null
#https://www.youtube.com/watch?v=04A7pUkhx3E
func _physics_process(_delta:float) -> void:
	detect_turn_around()
	if is_colliding():
		if get_collider() is Player:
			target = get_collider()
	
#detects both wall and player	
func detect_turn_around():
	if is_colliding() :
		print("turn around please.")
	else:
		print("do not turn around")
