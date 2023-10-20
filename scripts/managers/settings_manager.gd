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

static func save():
	config.save(CONFIG_PATH)
