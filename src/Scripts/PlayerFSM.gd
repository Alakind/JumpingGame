extends StateMachine

func _ready():
	add_state("run")
	add_state("jump")
	add_state("fall")
	add_state("dead")
	add_state("attack")
	call_deferred("set_state", states.run)
	
func _input(event):
	#Jump
	if [states.run].has(state):
		if event.is_action_pressed("jump") && parent.is_on_floor():
			parent.direction.y = -1.0
			
	if [states.jump, states.fall].has(state):
		parent.direction.y = 1.0
		parent.is_jumping = true

func _state_logic(delta):
	parent._handle_move_input()
	parent._apply_gravity(delta)
	parent._apply_movement()
	
func _get_transition(delta):
	match state:
		states.run:
			if !parent.is_on_floor():
				if parent._velocity.y < 0:
					return states.jump
				elif parent._velocity.y > 0:
					return states.fall
		states.jump:
			if parent.is_on_floor():
				return states.run
			elif parent._velocity.y >= 0:
				return states.fall
		states.fall:
			if parent.is_on_floor():
				return states.run
			elif parent._velocity.y < 0:
				return states.jump
	return null
	
func _enter_state(new_state, old_state):
	match new_state:
		states.run:
			parent.anim_player.play("Run")
		states.jump:
			parent.anim_player.play("Jump")
		states.fall:
			parent.anim_player.play("Fall")
