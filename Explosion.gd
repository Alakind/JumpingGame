extends AnimatedSprite

func _on_Explosion_animation_finished() -> void:
	var sound = $"Explosion"
	queue_free()
	sound.play()
