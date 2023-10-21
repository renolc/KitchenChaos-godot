class_name KeymapButton
extends Button

@export var action: String

signal bind_pressed(btn)

func _ready():
	update_text()

func _pressed():
	bind_pressed.emit(self)

func update_text():
	var action_name = InputMap.action_get_events(action)[0].as_text()

	if action_name.match("Joypad*"):
		text = get_joypad_button_text(action_name)
	else:
		text = get_keyboard_key_text(action_name)

func get_keyboard_key_text(action_name) -> String:
	return action_name.split(" ")[0].to_upper()

var joypad_buttons = {
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

func get_joypad_button_text(action_name) -> String:
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
		return joypad_buttons["PlayStation"][action_position]

	if joypad_name.match("*Nintendo*"):
		return joypad_buttons["Nintendo"][action_position]

	return joypad_buttons["Xbox"][action_position]
