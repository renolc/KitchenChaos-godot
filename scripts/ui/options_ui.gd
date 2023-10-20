extends Control

@onready var sfx_progress: ProgressBar = $Volume/SFX/ProgressBar
@onready var music_progress: ProgressBar = $Volume/Music/ProgressBar

const CONFIG_PATH = "user://settings.cfg"
const VOL_SECTION = "Volume"
const MUSIC_KEY = "Music"
const SFX_KEY = "SFX"

var music_bus_idx: int
var sfx_bus_idx: int
var config := ConfigFile.new()

func _ready():
	music_bus_idx = AudioServer.get_bus_index(MUSIC_KEY)
	sfx_bus_idx = AudioServer.get_bus_index(SFX_KEY)

	if config.load(CONFIG_PATH) == OK:
		AudioServer.set_bus_volume_db(music_bus_idx, linear_to_db(config.get_value(VOL_SECTION, MUSIC_KEY, 1.0)))
		AudioServer.set_bus_volume_db(sfx_bus_idx, linear_to_db(config.get_value(VOL_SECTION, SFX_KEY, 1.0)))

	music_progress.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus_idx))
	sfx_progress.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus_idx))

func music_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus_idx, linear_to_db(value))

func sfx_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus_idx, linear_to_db(value))

func paused_changed(is_paused):
	if !is_paused:
		close()

func close():
	visible = false
	config.set_value(VOL_SECTION, MUSIC_KEY, music_progress.value)
	config.set_value(VOL_SECTION, SFX_KEY, sfx_progress.value)
	config.save(CONFIG_PATH)
