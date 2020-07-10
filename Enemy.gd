extends Actor


var direction = 1
var is_dead = false
func _ready():
	_velocity.x = -speed.x
	
	
func dead():
	is_dead = true
	_velocity.x = 0
	$AnimatedSprite.play("dead")
	$CollisionShape2D.disabled = true
	$Timer.start()
	
	
func _physics_process(delta):
	if !is_dead:
		var music_node_steps = $"Sound of steps"
		_velocity.y += gravity * delta
		if is_on_wall():
			_velocity.x *= -1.0
			direction *= -1
			$RayCast2D.position.x *= -1
	
		if !$RayCast2D.is_colliding():
			_velocity.x *= -1.0
			direction *= -1
			$RayCast2D.position.x *= -1
			
		_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
		$AnimatedSprite.flip_h = direction == 1
		music_node_steps.play()
		$AnimatedSprite.play("run")
	


func _on_Timer_timeout() -> void:
	queue_free()
