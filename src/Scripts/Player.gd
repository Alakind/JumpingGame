extends Actor

var is_dead = false
var just_killed = false
var direction = Vector2(1, 0)
var is_jumping = false
onready var anim_player = get_node("AnimatedSprite")
onready var timer = get_node("Timer")
onready var collider = get_node("CollisionShape2D")

func _apply_gravity(delta):
	_velocity.y += gravity * delta

func _apply_movement():
	_velocity = calculate_velocity(_velocity, direction, speed)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func _handle_move_input():
	if is_on_wall():
		direction.x *= -1
		$AnimatedSprite.flip_h = direction.x == -1

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

func dead():
	is_dead = true
	_velocity = Vector2(0, 0)
