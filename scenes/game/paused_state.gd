extends State

signal changed_state
signal toggled_pause

var resumed : bool

func enter():
	get_tree().paused = true
	resumed = false
	toggled_pause.emit(true)

func exit():
	get_tree().paused = false
	toggled_pause.emit(false)

func update(delta):
	if Input.is_action_just_pressed("resume") or resumed:
		changed_state.emit(self, "PlayingState")
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _on_pause_menu_resume_button_pressed():
	resumed = true
