extends RayCast
onready var  laser_attack =  preload("res://scenes/Projectiles/nef_head_laser.tscn")
var target: Player = null
#to do: make the shooting animation and have it activate when the nef_head sees the player
#to do : make so that when it shoots but it being odd
#https://www.youtube.com/watch?v=04A7pUkhx3E
func _physics_process(_delta:float) -> void:
	if is_colliding():
		if get_collider() is Player:
			print("sees player")
			var attack = laser_attack.instance()
			get_parent().add_child(attack)
			
