extends Spatial

export (String, "crate_destroy", "lamp_post_destroy", "health_destroy") var sound_name

onready var destroy_sound = $Audio/DestroySound
onready var root_src = "res://resources/audio/environment/destructibles/"

# Called when the node enters the scene tree for the first time.
func _ready():
	# Match the sound name with the correct audio file.
	match sound_name:
		"crate_destroy":
			destroy_sound.set_stream(load(root_src + "crate_0.wav"))
			destroy_sound.play()
		"lamp_post_destroy":
			destroy_sound.set_stream(load(root_src + "vase_0.wav"))
			destroy_sound.play()
		"health_destroy":
			destroy_sound.set_stream(load(root_src + "glass_0.wav"))
			destroy_sound.play()
	$ExpireTimer.connect("timeout", self, "_on_ExpireTimer_timeout")
	$KillTimer.connect("timeout", self, "_on_KillTimer_timeout")
	$ExpireTimer.start()

# Crate fragments expiration.
func _on_ExpireTimer_timeout():
	queue_free()

# Used when the fadeout is in the place.
func _on_KillTimer_timeout():
	pass
