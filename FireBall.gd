extends RigidBody2D

var explosion = preload("res://Explosion.tscn")

func _on_FireBall_body_entered(body):
	if !body.is_in_group("player"):
		var explosion_instance = explosion.instance()
		explosion_instance.position = get_global_position()
		get_tree().get_root().add_child(explosion_instance)
		if "Enemy" in body.name:
			body.dead()
		queue_free()
