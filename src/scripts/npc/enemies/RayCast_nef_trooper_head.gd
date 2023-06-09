extends RayCast

var target: Player = null
#https://www.youtube.com/watch?v=04A7pUkhx3E
func _physics_process(_delta:float) -> void:
	if is_colliding():
		if get_collider() is Player:
			target = get_collider()
			print("bad guy sees player")
