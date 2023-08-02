extends CharacterBody2D

class_name Ball

signal ball_collided
signal x_direction_changed

const SPEED = 300.0

func _ready():
	add_to_group("balls")

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info != null:
		var collider_velocity = collision_info.get_collider_velocity()
		var bounced_velocity = velocity.bounce(collision_info.get_normal())
		var vel_x = bounced_velocity.x
		var vel_y = bounced_velocity.y
		if (collider_velocity.x > 0):
			vel_x = (vel_x + collider_velocity.x) / 2
		velocity = Vector2(vel_x, vel_y)
#		if (collider_velocity.x > 0):
#			print("Paddle:",velocity)
#		else:
#			print("Wall:",velocity)
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
	set_random_initial_velocity()

func set_random_initial_velocity():
	var x_direction = randi() % 50 + 41 if randi() % 2 == 0 else -randi() % 50 - 41
	var y_direction = 60 if randi() % 2 == 0 else -60
	velocity.x = x_direction * 0.01 * SPEED
	velocity.y = y_direction * 0.01 * SPEED

func _on_player_net_body_entered(body):
	if body is Ball:
		get_tree().call_group("playingState", "on_player_net_entered")

func _on_adversary_net_body_entered(body):
	if body is Ball:
		get_tree().call_group("playingState", "on_adversary_net_entered")
