extends State

signal changed_state
signal toggled_initial_state

func enter():
	get_tree().call_group("balls", "reset_ball_initial_position")
	toggled_initial_state.emit(true)

func exit():
	get_tree().call_group("balls", "restart_ball_movement")
	toggled_initial_state.emit(false)

func update(delta):
	if Input.is_action_just_pressed("start_game"):
		changed_state.emit(self, "PlayingState")
