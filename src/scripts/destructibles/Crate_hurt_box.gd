class_name Crate_hurt_Box
extends Area 

func _init() ->void:
	collision_layer =0
	collision_mask=2
	
func _ready() -> void: 
	connect("area_entered",self,"_on_area_entered")
	connect("area_exited",self,"_on_area_exit")

func _on_area_entered(hitbox:PlayerHit_box) -> void:
	if hitbox ==null:
		return 
	elif owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
		
func _on_area_exit(hitbox:PlayerHit_box) -> void:
	if hitbox ==null:    
		return 
	elif owner.has_method("no_damage"):
		owner.no_damage(0)
		
func _on_Crate_hurt_Box_body_entered(body):
	if body.name == "BilzGunProjectile":
		print("test")
		pass
