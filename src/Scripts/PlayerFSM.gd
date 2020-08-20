#This is a class for player's state machine. It should be in a child node of player.

extends StateMachine

func _ready():
	add_state("run")
	add_state("jump")
	add_state("fall")
	add_state("dead")
	add_state("attack")
	add_state("wall_jump")
	call_deferred("set_state", states.run)
	
#Called when there is an input
func _input(event):
	#Jump
	if [states.run].has(state):
		if Input.is_action_just_pressed("jump") and parent.is_on_floor():
			parent.direction.y = -1.0
			
	if [states.jump, states.fall].has(state):
		parent.direction.y = 1.0
		
		
func _state_logic(delta):
	if ![states.dead].has(state):
		#If the player is not dead apply movement
		parent._handle_move_input()
		parent._apply_movement()
		
	if [states.jump, states.fall, states.wall_jump].has(state):
		#If player is jumping, falling or wall jumping - apply direction to "down" 
		parent.direction.y = 1.0
	
#Used for transition between states
func _get_transition(delta):
	match state:
		states.run:
			if parent.is_dead:
				return states.dead
			elif parent.just_killed:
					return states.attack
			elif !parent.is_on_floor():
				if parent.is_on_wall():
					return states.wall_jump
				elif parent._velocity.y < 0:
					return states.jump
				elif parent._velocity.y > 0:
					return states.fall
		states.jump:
			if parent.is_dead:
				return states.dead
			elif parent.just_killed:
					return states.attack
			elif parent.is_on_floor():
				return states.run
			elif parent.is_on_wall():
				parent.direction.y = -1.0
				return states.wall_jump
			elif parent._velocity.y >= 0:
				return states.fall

		states.fall:
			if parent.is_dead:
				return states.dead
			elif parent.just_killed:
					return states.attack
			elif parent.is_on_floor():
				return states.run
			elif parent.is_on_wall():
				parent.direction.y = -1.0
				return states.wall_jump
			elif parent._velocity.y < 0:
				return states.jump
				
		states.wall_jump:
			if parent.is_dead:
				return states.dead
			elif parent.just_killed:
					return states.attack
			elif parent.is_on_floor():
				parent.is_wall_jump = false
				return states.run
			elif parent.is_on_wall():
				parent.direction.y = -1.0
			elif parent._velocity.y >= 0:
				parent.is_wall_jump = false
				return states.fall
				
		states.attack:
			if parent.is_dead:
				return states.dead
			else:
				return states.jump
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
			parent.is_wall_jump = true
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
			parent.direction.y = -1.0
			parent.just_killed = false
			parent.anim_player.play("Attack")
			print("Attack")
			
