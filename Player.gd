extends Actor


var last_direction: = 1
var check_jumping: = 1.0
var steps_playing: = false
var is_dead = false
var just_killed = false

func _physics_process(delta: float) -> void:
	if !is_dead:
		var direction: = get_directions()
		_velocity = calculate_velocity(_velocity, direction, speed)
		_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
# Убивает любою касание врага, но необходимо поменять функцию dead(), убрать таймер
#	if get_slide_count() > 0:
#		for i in range(get_slide_count()):
#			if "Enemy" in get_slide_collision(i).collider.name:
#				dead()
	
	
	
func get_directions() -> Vector2:
	var music_node_steps = $"Auido Effect/AudioStreamPlayer"
	var music_node_jumps = $"Auido Effect/Sound of jump"
		
	if is_on_wall():
		last_direction *= -1
		#music_node_steps.play()
		$AnimatedSprite.play("Run")
		$AnimatedSprite.flip_h = last_direction == -1 
		
	if ( Input.is_action_just_pressed("jump") and is_on_floor() ) or ( is_on_wall() and not is_on_floor()) or just_killed == true:
		check_jumping = -1.0
		music_node_steps.stop()
		steps_playing = false
		music_node_jumps.play()
		$AnimatedSprite.play("Jump")
	elif not is_on_floor():
		check_jumping = 1.0
		music_node_steps.stop()
		steps_playing = false
		$AnimatedSprite.play("Falling")
	else:
		check_jumping = 1.0
		$AnimatedSprite.play("Run")
		
	if !steps_playing:
		music_node_steps.play()
		steps_playing = true
	return Vector2(last_direction, check_jumping)

func dead():
	is_dead =true
	_velocity = Vector2(0, -100)
	$AnimatedSprite.play(("Dead"))
	$CollisionShape2D.disabled = true
	$Timer.start()

func calculate_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	just_killed = false
	return out

func _on_Timer_timeout() -> void:
	get_tree().reload_current_scene()
