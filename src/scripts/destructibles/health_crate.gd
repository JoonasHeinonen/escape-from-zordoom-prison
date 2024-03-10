extends Destructible

@onready var nanotech_node = preload("res://scenes/Collectibles/nanotech_node.tscn")

func _process(delta):
	if Globle.melee_attack && is_active:
		generate_health_node()
		queue_free()

func _on_Area_area_entered(body):
	if body.name == "ProjectileExplosionArea" or body.name == "ExplosionEffectiveRadius":
		generate_health_node()
		queue_free()

func generate_health_node():
	# TODO Generate the health crate splinters.
	create_fragments()
	var n_n = nanotech_node.instantiate()
	get_parent().get_parent().get_parent().add_child(n_n)
	n_n.global_transform = global_transform
	queue_free()
