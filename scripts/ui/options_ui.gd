class_name OptionsUI
extends Control

@onready var sfx_progress: ProgressBar = $HBoxContainer/Volume/SFX/ProgressBar
@onready var music_progress: ProgressBar = $HBoxContainer/Volume/Music/ProgressBar
@onready var key_prompt: Panel = $KeyPrompt
@onready var buttons: Array[KeymapButton] = [
	$HBoxContainer/KeyMap/Up/Button,
	$HBoxContainer/KeyMap/Down/Button,
	$HBoxContainer/KeyMap/Left/Button,
	$HBoxContainer/KeyMap/Right/Button,
	$HBoxContainer/KeyMap/Interact/Button,
	$HBoxContainer/KeyMap/InteractAlt/Button,
	$HBoxContainer/KeyMap/Pause/Button
]

var music_bus_idx: int
var sfx_bus_idx: int
var binding_btn: KeymapButton

func _ready():
	music_bus_idx = AudioServer.get_bus_index(SettingsManager.MUSIC_KEY)
	sfx_bus_idx = AudioServer.get_bus_index(SettingsManager.SFX_KEY)

	if SettingsManager.load_cfg() == OK:
		AudioServer.set_bus_volume_db(music_bus_idx, SettingsManager.get_music_val())
		AudioServer.set_bus_volume_db(sfx_bus_idx, SettingsManager.get_sfx_val())

	music_progress.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus_idx))
	sfx_progress.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus_idx))

	SettingsManager.load_buttons(buttons)

func _unhandled_key_input(event):
	if binding_btn && event is InputEventKey:
		InputMap.action_erase_events(binding_btn.action)
		InputMap.action_add_event(binding_btn.action, event)
		binding_btn.update_text()
		binding_btn = null
		key_prompt.hide()

func music_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus_idx, linear_to_db(value))

func sfx_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus_idx, linear_to_db(value))

func paused_changed(is_paused):
	if !is_paused:
		close()

func close():
	hide()
	SettingsManager.set_volumes(music_progress.value, sfx_progress.value)
	SettingsManager.set_buttons(buttons)
	SettingsManager.save()

func bind_pressed(btn: KeymapButton):
	binding_btn = btn
	key_prompt.show()

func reset_bindings_pressed():
	InputMap.load_from_project_settings()
	buttons.map(func(i): i.update_text())
