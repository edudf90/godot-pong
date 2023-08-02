extends CharacterBody2D

const SPEED = 300.0
var efficiency = 0.6
var max_efficiency = 0.8
var ball : CharacterBody2D

func _ready():
	ball = get_tree().get_first_node_in_group("balls")
	reset_efficiency()

func _physics_process(delta):
	var direction = 0
	if (randi() % 100 + 1) * 0.01 < efficiency:
		if ball.position.x < position.x - 3:
			direction = -1
		if ball.position.x > position.x + 3:
			direction = 1
	velocity.x = direction * SPEED
	move_and_collide(velocity * delta)

func increase_efficiency(increment):
	if efficiency < max_efficiency:
		efficiency += increment

func reset_efficiency():
	efficiency = 0.5

func _on_player_net_body_entered(body):
	reset_efficiency()

func _on_adversary_net_body_entered(body):
	increase_efficiency(0.01)
