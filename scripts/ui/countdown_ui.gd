extends Control

@onready var label: Label = $Label

func _process(delta):
	if visible:
		label.text = str(ceil(GameManager.Instance.timer.time_left))

func state_changed(state: GameManager.State):
	visible = state == GameManager.State.Countdown
