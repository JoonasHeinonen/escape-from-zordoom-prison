extends ColorRect

signal fade_finished

func _process(delta):
	if (Globle.game_fullscreen):
		self.rect_size = Vector2(1920, 1080)
	elif (!Globle.game_fullscreen):
		self.rect_size = Vector2(1280, 720)

func fade_in():
	$AnimationPlayer.play("fade_in")

func _on_AnimationPlayer_animation_finished(_anim_name):
	emit_signal("fade_finished")
