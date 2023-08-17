extends ColorRect

signal fade_finished

# Plays the fade_in animation.
func fade_in():
	$AnimationPlayer.play("fade_in")

func _on_AnimationPlayer_animation_finished(_anim_name):
	emit_signal("fade_finished")
