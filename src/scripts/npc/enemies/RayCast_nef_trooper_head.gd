extends RayCast3D

@onready var  laser_attack =  preload("res://scenes/Projectiles/nef_head_laser.tscn")

var target: Player = null

signal player_seen 
signal player_not_seen

func _physics_process(_delta:float) -> void:
	if is_colliding():
		if get_collider() is Player:
			emit_signal("player_seen")
		elif get_collider() != Player:
			emit_signal("player_not_seen")
			pass
	else :
		# print("doesnt see player")
		pass
