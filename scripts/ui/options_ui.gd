extends Control

@onready var sfx_progress: ProgressBar = $SFX/ProgressBar
@onready var music_progress: ProgressBar = $Music/ProgressBar

var music_bus_idx: int
var sfx_bus_idx: int

func _ready():
	music_bus_idx = AudioServer.get_bus_index("Music")
	sfx_bus_idx = AudioServer.get_bus_index("SFX")

	music_progress.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus_idx))
	sfx_progress.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus_idx))

func music_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus_idx, linear_to_db(value))

func sfx_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus_idx, linear_to_db(value))

func close_pressed():
	visible = false

func paused_changed(is_paused):
	if !is_paused:
		visible = false
