extends Area3D 

func _init() -> void:
	collision_layer = 0
	collision_mask = 2

func _ready() -> void: 
	connect("area_entered", Callable(self, "_on_area_entered"))
	connect("area_exited", Callable(self, "_on_area_exit"))

## TODO Fix the following.
## emit_signalp: Error calling from signal 'area_entered' to callable: 'Area3D(crate_hurt_box.gd)::_on_area_entered': Cannot convert argument 1 from Object to Object.
func _on_area_entered(hitbox : PlayerHitBox) -> void:
	if hitbox == null:
		return 
	elif owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)

## TODO Fix the following.
## emit_signalp: Error calling from signal 'area_exited' to callable: 'Area3D(crate_hurt_box.gd)::_on_area_exit': Cannot convert argument 1 from Object to Object.
func _on_area_exit(hitbox : PlayerHitBox) -> void:
	if hitbox == null:    
		return 
	elif owner.has_method("no_damage"):
		owner.no_damage(0)

## TODO Do we need this function in the first place?
func _on_Crate_hurt_Box_body_entered(body):
	if body.name == "BilzGunProjectile":
		pass
