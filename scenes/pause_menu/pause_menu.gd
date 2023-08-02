extends Control

signal resume_button_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	var resume_button = find_child("ResumeButton")
	var quit_button = find_child("QuitButton")
	resume_button.connect("pressed", _on_resume_button_pressed)
	quit_button.connect("pressed", _on_quit_button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_paused_state_toggled_pause(is_paused):
	if is_paused:
		show()
	else:
		hide()

func _on_resume_button_pressed():
	resume_button_pressed.emit()

func _on_quit_button_pressed():
	get_tree().quit()
