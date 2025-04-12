extends Node

class_name GrapplingHookHelper

@export var ray : RayCast3D

@export var rest_length = 2.0
@export var stiffness = 10.0
@export var damping = 1.0

@onready var player : CharacterBody3D

var target : Vector3
var launched : bool = false

func _ready():
	player = get_parent()

func _physics_process(delta):
	if Input.is_action_pressed("ui_gadget"): 
		launch()
	if Input.is_action_just_released("ui_gadget"): 
		retract()
	
	if launched:
		handle_grapple(delta)

func launch():
	if ray.is_colliding():
		target = ray.get_collision_point()
		launched = true

func retract():
	launched = false

func handle_grapple(delta : float):
	var target_dir = player.global_position.direction_to(target)
	var target_dist = player.global_position.distance_to(target)

	var displacement = target_dist - rest_length
	var force = Vector3.ZERO

	print(displacement)
	if displacement > 0:
		var spring_force_magnitude = stiffness * displacement
		var spring_force = target_dir * spring_force_magnitude

		var vel_dot = player.velocity.dot(target_dir)
		var damping = -damping * vel_dot * target_dir

		force = spring_force + damping
		print(force)

	print(player.velocity)
	player.velocity += force * delta
