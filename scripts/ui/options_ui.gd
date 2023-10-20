class_name OptionsUI
extends Control

@onready var sfx_progress: ProgressBar = $HBoxContainer/Volume/SFX/ProgressBar
@onready var music_progress: ProgressBar = $HBoxContainer/Volume/Music/ProgressBar
@onready var key_prompt: Panel = $KeyPrompt

signal bindings_reset

const CONFIG_PATH = "user://settings.cfg"
const VOL_SECTION = "Volume"
const MUSIC_KEY = "Music"
const SFX_KEY = "SFX"

var music_bus_idx: int
var sfx_bus_idx: int
var config := ConfigFile.new()
var binding_btn: KeymapButton

func _ready():
	music_bus_idx = AudioServer.get_bus_index(MUSIC_KEY)
	sfx_bus_idx = AudioServer.get_bus_index(SFX_KEY)

	if config.load(CONFIG_PATH) == OK:
		AudioServer.set_bus_volume_db(music_bus_idx, linear_to_db(config.get_value(VOL_SECTION, MUSIC_KEY, 1.0)))
		AudioServer.set_bus_volume_db(sfx_bus_idx, linear_to_db(config.get_value(VOL_SECTION, SFX_KEY, 1.0)))

	music_progress.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus_idx))
	sfx_progress.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus_idx))

func _unhandled_input(event):
	if binding_btn && event is InputEventKey:
		get_viewport().set_input_as_handled()
		InputMap.action_erase_events(binding_btn.action)
		InputMap.action_add_event(binding_btn.action, event)
		binding_btn.update_text()
		binding_btn = null
		key_prompt.visible = false

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

func bind_pressed(btn: KeymapButton):
	binding_btn = btn
	key_prompt.visible = true

func reset_bindings_pressed():
	InputMap.load_from_project_settings()
	bindings_reset.emit()
