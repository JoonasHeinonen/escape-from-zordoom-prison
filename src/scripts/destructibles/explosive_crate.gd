extends "res://src/scripts/destructibles/destructible.gd"

onready var explosion = preload("res://scenes/Effects/Explosions/ExplosiveCrateExplosion.tscn")
onready var countdown = $Timer.time_left

var state_machine

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	$Timer.connect("timeout", self, "_on_Timer_timeout")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globle.melee_attack && active:
		state_machine.travel("Activated")
		$Timer.start()

func take_damage(amount : int) -> void:
	active = true

func no_damage(amount : int) -> void:
	active = false

# Destroys the crate, generate the explosion.
func generate_explosion():
	var expl = explosion.instance()
	expl.translation.x = 3
	get_parent().add_child(expl)
	expl.global_transform = $ExplosiveCrate.global_transform
	queue_free()

# Detects the collisions on this scene.
func _on_Area_area_entered(body):
	if body.name == "ProjectileExplosionArea":
		state_machine.travel("Activated")
		$Timer.start()
	elif body.name == "ExplosionEffectiveRadius":
		generate_explosion()

# Timer timeout.
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
