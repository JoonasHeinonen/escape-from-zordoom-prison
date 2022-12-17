class_name Crate_hurt_Box
extends Area 

func _init() ->void:
	collision_layer =0
	collision_mask=2
	
func _ready() -> void: 
	connect("area_entered",self,"_on_area_entered")
	connect("area_exit",self,"_on_area_exit")

func _on_area_entered(hitbox:PlayerHit_box) -> void:
	if hitbox ==null:
		return 
	elif owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
		

func _on_area_exit(hitbox) -> void:
	if hitbox.body =="PlayerHit_box":
		print("exit")
		pass
		 
	
