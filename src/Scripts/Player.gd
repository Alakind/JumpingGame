extends Actor

var is_dead = false
var just_killed = false
var direction = Vector2(1, 0)
var is_jumping = false
export var wall_jump_speed = Vector2(800.0, 2800.0)
var is_wall_jump = false

onready var anim_player = get_node("AnimatedSprite")

#Timer for reload a scene after death
onready var timer = get_node("Timer")
onready var collider = get_node("CollisionShape2D")

#Apply the movement of player
func _apply_movement():
	if !is_wall_jump:
		_velocity = calculate_velocity(_velocity, direction, speed)
	else:
		_velocity = calculate_velocity(_velocity, direction, wall_jump_speed)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

#Apply the direction of player
func _handle_move_input():
	if is_on_wall():
		direction.x *= -1
		$AnimatedSprite.flip_h = direction.x == -1

#Calculate the velocity
func calculate_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		#If the player jumps
		out.y = speed.y * direction.y
	return out

#Timer for reload a scene after death
func _on_Timer_timeout() -> void:
	get_tree().reload_current_scene()

func dead():
	is_dead = true
