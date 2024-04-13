extends Destructible

@onready var explosion = preload("res://scenes/Effects/Explosions/ExplosiveCrateExplosion.tscn")
@onready var countdown = $Timer.time_left

var state_machine

func _ready():
	state_machine = $AnimationTree.get("parameters/playback")

func _process(_delta):
	if Globle.melee_attack && is_active:
		state_machine.travel("Activated")
		$Timer.start()

func take_damage(_amount : int) -> void:
	is_active = true

func no_damage(_amount : int) -> void:
	is_active = false

func generate_explosion():
	var expl = explosion.instantiate()
	expl.position.x = 3
	get_parent().add_child(expl)
	expl.global_transform = $ExplosiveCrate.global_transform
	queue_free()

func _on_Area_area_entered(body):
	if body.name == "ProjectileExplosionArea":
		state_machine.travel("Activated")
		$Timer.start()
	elif body.name == "ExplosionEffectiveRadius":
		generate_explosion()

func _on_Timer_timeout():
	countdown -= 1
	if countdown <= 0:
		generate_explosion()

func _on_explosive_crate_mouse_entered():
	add_active_radical()

func _on_explosive_crate_mouse_exited():
	remove_active_radical()

func _on_ExplosiveCrate_mouse_entered():
	add_active_radical()

func _on_ExplosiveCrate_mouse_exited():
	remove_active_radical()
