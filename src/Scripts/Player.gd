extends Actor

var last_direction: = 1
var is_dead = false
var just_killed = false
var direction = Vector2(1, 0)
var is_jumping = false
onready var anim_player = get_node("AnimatedSprite")


func _apply_gravity(delta):
	_velocity.y += gravity * delta
	
func _apply_movement():
	_velocity = calculate_velocity(_velocity, direction, speed)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
func _handle_move_input():
	if is_on_wall():
		last_direction *= -1
		$AnimatedSprite.flip_h = last_direction == -1
	direction.x = last_direction

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
