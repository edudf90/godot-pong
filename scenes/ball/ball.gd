extends CharacterBody2D

class_name Ball

signal ball_collided
signal x_direction_changed
const SPEED = 250.0

const LOWEST_INCLINATION = 0
const INITIAL_DIRECTION = 1
const HIGHEST_INCLINATION = 3
const DIRECTIONS = {
	0: Vector2(0.866025, -0.5), 
	1: Vector2(0.707107, -0.707107),
	2: Vector2(0.5, -0.866025),
	3: Vector2(0.2588, -0.9659)
	}
	
var direction = INITIAL_DIRECTION

func _ready():
	add_to_group("balls")

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info != null:
		var collider_velocity = collision_info.get_collider_velocity()
		var bounced_velocity = velocity.bounce(collision_info.get_normal())
		var vel_x = bounced_velocity.x
		var vel_y = bounced_velocity.y
		var collider = collision_info.get_collider()
		velocity = Vector2(vel_x, vel_y).normalized() * SPEED
		if collider is CharacterBody2D && collider_velocity.x != 0:
			var direction_multiplier = Vector2(1.0, 1.0)
			if (sign(collider_velocity.x) == sign(velocity.x)):
				direction = max(direction - 1, LOWEST_INCLINATION);
			else:
				if (direction == HIGHEST_INCLINATION):
					direction_multiplier = direction_multiplier * Vector2(-1.0, 1.0)
				direction = min(direction + 1, HIGHEST_INCLINATION);
			if velocity.x < 0:
				direction_multiplier = direction_multiplier * Vector2(-1.0, 1.0)
			velocity = DIRECTIONS[direction] * direction_multiplier * SPEED
		ball_collided.emit()

func reset_ball_initial_position():
	stop_ball()
	reposition_ball()

func reposition_ball():
	position.x = 275
	position.y = 325

func stop_ball():
	velocity.x = 0
	velocity.y = 0

func restart_ball_movement():
	direction = randi() % 3
	var direction_multiplier = Vector2(1.0, 1.0)
	match randi() % 4:
		0:
			direction_multiplier = Vector2(1.0, 1.0)
		1:
			direction_multiplier = Vector2(-1.0, 1.0)
		2:
			direction_multiplier = Vector2(1.0, -1.0)
		3:
			direction_multiplier = Vector2(-1.0, -1.0)
	velocity = DIRECTIONS[direction] * direction_multiplier * SPEED

func _on_player_net_body_entered(body):
	if body is Ball:
		get_tree().call_group("playingState", "on_player_net_entered")

func _on_adversary_net_body_entered(body):
	if body is Ball:
		get_tree().call_group("playingState", "on_adversary_net_entered")
