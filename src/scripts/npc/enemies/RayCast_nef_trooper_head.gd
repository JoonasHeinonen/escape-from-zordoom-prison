extends RayCast
onready var  laser_attack =  preload("res://scenes/Projectiles/nef_head_laser.tscn")
var target: Player = null
signal player_seen 
#to do: make the shooting animation and have it activate when the nef_head sees the player
#to do : make so that when it shoots but it being odd
#https://www.youtube.com/watch?v=04A7pUkhx3E
func _physics_process(_delta:float) -> void:
	if is_colliding():
		if get_collider() is Player:
			emit_signal("player_seen")
			print("sees player")
		elif get_collider() != Player:
			print("is not player")
	else :
		print("doesnt see player")
