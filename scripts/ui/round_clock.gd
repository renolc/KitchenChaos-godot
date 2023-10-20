extends Control

@onready var progress: TextureProgressBar = $ProgressBar

func _process(_delta):
	if GameManager.Instance.state == GameManager.State.Playing:
		progress.value = 1 - GameManager.Instance.timer.time_left / GameManager.PLAYING_TIME
