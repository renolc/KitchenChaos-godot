extends Node

func get_movement_vector() -> Vector2:
	var keyboard_vector := Input.get_vector("left", "right", "up", "down")
	var gamepad_vector := Input.get_vector("gamepad_left", "gamepad_right", "gamepad_up", "gamepad_down")

	if keyboard_vector.length() > gamepad_vector.length():
		return keyboard_vector

	return gamepad_vector

func get_right_stick_x_axis() -> float:
	return Input.get_axis("ui_focus_left", "ui_focus_right")

func interact_just_pressed() -> bool:
	return Input.is_action_just_pressed("interact") || Input.is_action_just_pressed("gamepad_interact")

func interact_alt_just_pressed() -> bool:
	return Input.is_action_just_pressed("interact_alt") || Input.is_action_just_pressed("gamepad_interact_alt")

func paused_just_pressed() -> bool:
	return Input.is_action_just_pressed("pause") || Input.is_action_just_pressed("gamepad_pause")

func get_key_text_from_action(action: String) -> String:
	var action_name = InputMap.action_get_events(action)[0].as_text()

	if action_name.match("Joypad*"):
		return get_joypad_button_text(action_name)

	return get_keyboard_key_text(action_name)

const JOYPAD_BUTTONS = {
	"Xbox": {
		"top": "Y",
		"right": "B",
		"bottom": "A",
		"left": "X",
		"start": "Menu",
		"select": "Back"
	},
	"PlayStation": {
		"top": "△",
		"right": "o",
		"bottom": "x",
		"left": "□",
		"start": "▶",
		"select": "▬"
	},
	"Nintendo": {
		"top": "X",
		"right": "A",
		"bottom": "B",
		"left": "Y",
		"start": "+",
		"select": "-"
	}
}

func get_keyboard_key_text(action_name) -> String:
	return action_name.split(" ")[0].to_upper()

func get_joypad_button_text(action_name) -> String:
	if Input.get_connected_joypads().size() < 1: return "-"

	var action_position

	if action_name.match("*Bottom Action*"):
		action_position = "bottom"
	elif action_name.match("*Top Action*"):
		action_position = "top"
	elif action_name.match("*Left Action*"):
		action_position = "left"
	elif action_name.match("*Right Action*"):
		action_position = "right"
	elif action_name.match("*Start*"):
		action_position = "start"
	elif action_name.match("*Sony Select*"):
		action_position = "select"

	var joypad_name = Input.get_joy_name(0)

	if joypad_name.match("*PlayStation*") || joypad_name.match("*PS3*") || joypad_name.match("*PS4*") || joypad_name.match("*PS5*"):
		return JOYPAD_BUTTONS["PlayStation"][action_position]

	if joypad_name.match("*Nintendo*"):
		return JOYPAD_BUTTONS["Nintendo"][action_position]

	return JOYPAD_BUTTONS["Xbox"][action_position]
