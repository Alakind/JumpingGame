extends Actor


var direction = 1
var is_dead = false
var is_attacking = false

func _ready():
	_velocity.x = -speed.x
	
	
func dead():
	is_dead = true
	_velocity.x = 0
	$AnimatedSprite.play("dead")
	$CollisionShape2D.disabled = true
	$Stomping_area/CollisionShape2D.disabled = true
	$RayCast2D.enabled = false
	$Timer.start()

# Killing enemy by stomping
func _on_Stomping_area_body_entered(body):
	# If enemy is lower
	if body.global_position.y < get_node("Stomping_area").global_position.y:
		dead()
		body.just_killed = true
		#body.music_node_steps.stop()
		#body.steps_playing = false
		#body.music_node_jumps.play()
		$AnimatedSprite.play("Jump")

func _physics_process(delta):
	if !is_dead:
		var music_node_steps = $"Sound of steps"
		_velocity.y += gravity * delta
		
		#Убивает, только если враг лицом
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Player" in get_slide_collision(i).collider.name:
					is_attacking = true
					$AnimatedSprite.play("attack")
					_velocity.x = 0
					$"Timer for attack".start()
					get_slide_collision(i).collider.dead()
					
		if is_on_wall():
			_velocity.x *= -1.0
			direction *= -1
			$RayCast2D.position.x *= -1
	
		if !$RayCast2D.is_colliding():
			_velocity.x *= -1.0
			direction *= -1
			$RayCast2D.position.x *= -1


		_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

		if not is_attacking:
			$AnimatedSprite.flip_h = direction == 1
			$AnimatedSprite.play("run")


func _on_Timer_timeout() -> void:
	queue_free()


func _on_Timer_for_attack_timeout() -> void:
	is_attacking = false
	_velocity.x = speed.x * -direction
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

