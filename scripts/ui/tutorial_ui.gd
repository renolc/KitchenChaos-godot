extends Control

func _ready():
	show()

func state_changed(state: GameManager.State):
	if state == GameManager.State.Countdown:
		hide()
