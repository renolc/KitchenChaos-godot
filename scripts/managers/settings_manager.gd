class_name SettingsManager
extends Node

const CONFIG_PATH = "user://settings.cfg"

const VOL_SECTION = "Volume"
const MUSIC_KEY = "Music"
const SFX_KEY = "SFX"

const KEYMAP_SECTION = "Keymap"

static var config := ConfigFile.new()

static func load_cfg() -> Error:
	return config.load(CONFIG_PATH)

static func get_music_val() -> float:
	return linear_to_db(config.get_value(VOL_SECTION, MUSIC_KEY, 1.0))

static func get_sfx_val() -> float:
	return linear_to_db(config.get_value(VOL_SECTION, SFX_KEY, 1.0))

static func set_volumes(music: float, sfx: float):
	config.set_value(VOL_SECTION, MUSIC_KEY, music)
	config.set_value(VOL_SECTION, SFX_KEY, sfx)

static func set_buttons(buttons: Array[KeymapButton]):
	buttons.map(func(btn: KeymapButton):
		if btn.is_joypad:
			config.set_value(KEYMAP_SECTION, btn.action, InputManager.get_joypad_button_text(btn))
		else:
			config.set_value(KEYMAP_SECTION, btn.action, btn.text)
	)

static func load_buttons(buttons: Array[KeymapButton]):
	buttons.map(func(btn: KeymapButton):
		var key_txt = config.get_value(KEYMAP_SECTION, btn.action, -1)
		if !key_txt || key_txt == "-1": return

		if btn.is_joypad:
			InputManager.joypad_bindings[btn.action] = int(key_txt)
		else:
			var event := InputEventKey.new()
			event.set_keycode(OS.find_keycode_from_string(key_txt))
			InputMap.action_erase_events(btn.action)
			InputMap.action_add_event(btn.action, event)

		btn.update_text()
	)

static func save():
	config.save(CONFIG_PATH)
