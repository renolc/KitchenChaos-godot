extends Control

func state_changed(state: GameManager.State):
	print(state)
	if state != GameManager.State.WaitingToStart:
		hide()
