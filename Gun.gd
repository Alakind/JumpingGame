extends KinematicBody2D


var bullet = preload("res://FireBall.tscn")
export var bullet_speed = 1000
export var fire_rate = 0.2
var can_fire = true

func _process(delta):
	var sound_of_fireball = $"Fireball"
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("fire") and can_fire:
		sound_of_fireball.play()
		var bullet_instance = bullet.instance()
		bullet_instance.position = $BulletPoint.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
