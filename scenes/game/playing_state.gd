extends State

signal changed_state
signal player_scored
signal adversary_scored

var player_score : int
var adversary_score : int

func _ready():
	player_score = 0
	adversary_score = 0
	add_to_group("playingState")

func enter():
	pass

func exit():
	pass

func update(delta):
	if Input.is_action_just_pressed("pause"):
		changed_state.emit(self, "PausedState")

func on_adversary_net_entered():
	player_score += 1
	player_scored.emit(player_score)
	go_to_initial_state()

func on_player_net_entered():
	adversary_score += 1
	adversary_scored.emit(adversary_score)
	go_to_initial_state()

func go_to_initial_state():
	changed_state.emit(self, "InitialState")
