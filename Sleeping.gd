extends StateMachine

func _state_logic(delta):
	add_state("sleep")
	
	
func _get_transition(delta):
	return null
	
func _enter_state(new_state, old_state):
	pass

func _exit_state(old_state, new_state):
	pass
