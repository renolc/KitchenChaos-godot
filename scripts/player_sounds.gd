extends Node3D

@onready var timer: Timer = $StepTimer
@onready var audio_player: SfxManager = $StepSfxManager

var player: Player

func _ready():
	player = get_parent()

func timer_timeout():
	if player.is_walking:
		audio_player.play_random()
