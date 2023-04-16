extends Camera

# Max and Min in the x axis
export var xMax = 0.0
export var yMax = 0.0  

# Max and Min in the y axis
export var xMin = 0.0
export var yMin = 0.0

# Smooth Camera Trigger and SmoothSpeed value
export var smooth = false
export var smooth_speed = 1

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	player = get_parent().get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var Target = get_node(".").get_translation()
	var Own = get_node(".")

	var Start = get_node(".").get_translation()

	var Clampx = clamp(Target.x, xMin, xMax)
	var Clampy = clamp(Target.y, yMin, yMax)
	var Clampz = Own.get_translation().z

	var All = Vector3(Clampx, Clampy, Clampz)


