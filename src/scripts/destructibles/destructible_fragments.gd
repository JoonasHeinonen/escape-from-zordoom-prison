extends Node3D

@export (String, "crate_destroy", "lamp_post_destroy", "health_destroy") var sound_name

@onready var destroy_sound = $Audio/DestroySound
@onready var root_src = "res://resources/audio/environment/destructibles/"

func _ready():
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
	$ExpireTimer.connect("timeout", Callable(self, "_on_ExpireTimer_timeout"))
	$KillTimer.connect("timeout", Callable(self, "_on_KillTimer_timeout"))
	$ExpireTimer.start()

func _physics_process(delta):
	if (self.has_node("Audio")):
		for audio_child in $Audio.get_children():
			audio_child.position = Vector3(self.position.x, self.position.y, 0)

func _on_ExpireTimer_timeout():
	queue_free()

func _on_KillTimer_timeout():
	pass
