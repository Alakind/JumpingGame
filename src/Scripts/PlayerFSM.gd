extends StateMachine

func _ready():
	add_state("run")
	add_state("jump")
	add_state("fall")
	add_state("dead")
	add_state("attack")
	add_state("wall_jump")
	call_deferred("set_state", states.run)
	
func _input(event):
	#Jump
	if [states.run].has(state):
		if Input.is_action_just_pressed("jump") and parent.is_on_floor():
			parent.direction.y = -1.0
			
	if [states.jump, states.fall].has(state):
		parent.direction.y = 1.0
		
	if [states.wall_jump].has(state):
		parent.direction.y = -1.0
		
func _state_logic(delta):
	if ![states.dead].has(state):
		parent._handle_move_input()
		#parent._apply_gravity(delta)
		parent._apply_movement()
	
func _get_transition(delta):
	match state:
		states.run:
			if parent.is_dead:
				return states.dead
			elif !parent.is_on_floor():
				if parent._velocity.y < 0:
					return states.jump
				elif parent._velocity.y > 0:
					return states.fall
		states.jump:
			parent.direction.y = 1.0
			if parent.is_dead:
				return states.dead
			elif parent.is_on_floor():
				return states.run
			elif parent.is_on_wall():
				parent.direction.y = -1.0
			elif parent._velocity.y >= 0:
				return states.fall

		states.fall:
			if parent.is_dead:
				return states.dead
			elif parent.is_on_floor():
				return states.run
			elif parent.is_on_wall():
				parent.direction.y = -1.0
			elif parent._velocity.y < 0:
				return states.jump
		states.wall_jump:
			if parent.is_dead:
				return states.dead
	return null
	
func _enter_state(new_state, old_state):
	match new_state:
		states.run:
			parent.anim_player.play("Run")
			print("Run")
		states.jump:
			parent.anim_player.play("Jump")
			print("Jump")
		states.wall_jump:
			parent.anim_player.play("Wall_jump")
			print("Wall Jump")
		states.fall:
			parent.anim_player.play("Fall")
			print("Fall")
		states.dead:
			parent.anim_player.play("Dead")
			parent.collider.disabled = true
			parent.timer.start()
		states.attack:
			parent.anim_player.play("Attack")
			print("Attack")
