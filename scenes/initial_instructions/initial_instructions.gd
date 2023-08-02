extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_initial_state_toggled_initial_state(in_initial_state):
	if in_initial_state:
		show()
	else:
		hide()
