extends RayCast
onready var  laser_attack =  preload("res://scenes/Projectiles/nef_head_laser.tscn")
var target: Player = null
signal player_seen 
signal player_not_seen
#to do: make the shooting animation and have it activate when the nef_head sees the player
#to do : make so that when it shoots but it being odd
#https://www.youtube.com/watch?v=04A7pUkhx3E

var timer = Timer.new()

var can_shoot = true
func _ready():
	timer.connect("timeout", self, "nef_head_shoot_time")
	timer.wait_time = 0
	timer.one_shot = true
	add_child(timer)
	timer.start()
	nef_head_shoot_time()
	
	
func _physics_process(_delta:float) -> void:
	if is_colliding():
		if get_collider() is Player:
			emit_signal("player_seen")
			print(timer)
		elif get_collider() != Player:
			#print("is not player")
			pass
			
	else :
		#print("doesnt see player")
		pass

func nef_head_shoot_time():
	print('wait 10 seconds and do this....')
