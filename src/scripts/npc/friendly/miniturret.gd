extends CharacterBody3D

@onready var projectile = preload("res://scenes/Projectiles/MiniturretProjectile.tscn")

@onready var miniturret_gun = $MiniturretGun

var body_target = null
var turn_direction : String
var state_machine : AnimationNodeStateMachinePlayback

var miniturret_ammo : int = 12
var turn_increment : float = 0.05
var is_locked_on_target : bool = false

var directions : Array = ["up", "down"]

#var velocity = Vector3(0, 0, 0)
var random = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = $MiniturretAnimationTree.get("parameters/playback")

	# Set the rotation of the miniturret to default.
	self.rotation.y = 0
	self.rotation.z = 0

	random.randomize()
	turn_direction = directions[(random.randi_range(0, directions.size() - 1))]

	$ExpireTimer.connect("timeout", Callable(self, "_on_ExpireTimer_timeout"))
	$ExpireTimer.start()

	$TurnTimer.connect("timeout", Callable(self, "_on_TurnTimer_timeout"))
	$TurnTimer.start()

	$ShootTimer.connect("timeout", Callable(self, "_on_ShootTimer_timeout"))
	$ShootTimer.start()

	$Audio/Deploy.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (miniturret_ammo <= 0) : queue_free()
	if (!is_locked_on_target):
		if (turn_direction == "up"):
			miniturret_gun.rotation.z -= turn_increment
		elif (turn_direction == "down"):
			miniturret_gun.rotation.z += turn_increment

func _physics_process(delta):
	state_machine.travel("Start")
	velocity.y = -4
	set_velocity(velocity)
	set_up_direction(Vector3.UP)
	move_and_slide()

	if (is_locked_on_target):
		# https://godotengine.org/qa/74812/rotate-kinematiccharacter3d-towards-another-object-only
		var a = Vector2(body_target.get_global_transform().origin.x, body_target.get_global_transform().origin.z)
		var b = Vector2(global_transform.origin.x, global_transform.origin.z)
		miniturret_gun.rotation.z = get_angle(a, b) 

func _on_ExpireTimer_timeout():
	queue_free()

func _on_TurnTimer_timeout():
	if (turn_direction == "up"):
		turn_direction = "down"
	elif (turn_direction == "down"):
		turn_direction = "up"

func _on_ShootTimer_timeout():
	if (is_locked_on_target):
		var bullet = projectile.instantiate()
		get_parent().add_child(bullet)
		bullet.global_transform = $MiniturretGun/WeaponMuzzle.global_transform
		$Audio/MiniturretGun.play()
		miniturret_ammo -= 1

func _on_TargetDetectionArea_body_entered(body):
	if (body.has_meta("type") && body.get_meta("type") == "enemy"):
		is_locked_on_target = true
		body_target = body

func _on_TargetDetectionArea_body_exited(body):
	if (body.has_meta("type") && body.get_meta("type") == "enemy"):
		is_locked_on_target = false
		body_target = null

# https://godotengine.org/qa/74812/rotate-kinematiccharacter3d-towards-another-object-only
# Returns the difference between point a and point b and returns the difference.
func get_angle(a : Vector2, b : Vector2):
	var diff = Vector2(a.x - b.x, a.y - b.y)
	return atan2(diff.y, diff.x)
