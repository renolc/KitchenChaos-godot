extends Node

@onready var joypad_icons = {
	"unknown": preload("res://textures/joypad/unknown.png"),
	"face": {
		"up": preload("res://textures/joypad/face_top.png"),
		"down": preload("res://textures/joypad/face_bottom.png"),
		"left": preload("res://textures/joypad/face_left.png"),
		"right": preload("res://textures/joypad/face_right.png"),
		"start": preload("res://textures/joypad/start.png"),
		"select": preload("res://textures/joypad/select.png")
	},
	"shoulders": {
		"l1": preload("res://textures/joypad/l1.png"),
		"r1": preload("res://textures/joypad/r1.png")
	},
	"sticks":{
		"l3": preload("res://textures/joypad/l3.png"),
		"r3": preload("res://textures/joypad/r3.png")
	}
}

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

func update_button(btn: KeymapButton):
	var action_name = InputMap.action_get_events(btn.action)[0].as_text()

	if action_name.match("Joypad*"):
		btn.icon = get_joypad_icon(action_name)
		return

	btn.text = get_keyboard_key_text(action_name)

func get_keyboard_key_text(action_name) -> String:
	return action_name.split(" ")[0].to_upper()

func get_joypad_icon(action_name) -> Texture:
	if action_name.match("*Bottom Action*"):
		return joypad_icons.face.down

	if action_name.match("*Top Action*"):
		return joypad_icons.face.up

	if action_name.match("*Left Action*"):
		return joypad_icons.face.left

	if action_name.match("*Right Action*"):
		return joypad_icons.face.right

	if action_name.match("*Start*"):
		return joypad_icons.face.start

	if action_name.match("*Sony Select*"):
		return joypad_icons.face.select

	if action_name.match("*Sony L3*"):
		return joypad_icons.sticks.l3

	if action_name.match("*Sony R3*"):
		return joypad_icons.sticks.r3

	if action_name.match("*Sony L1*"):
		return joypad_icons.shoulders.l1

	if action_name.match("*Sony R1*"):
		return joypad_icons.shoulders.r1

	return joypad_icons.unknown

func is_valid_joypad_event(event: InputEvent) -> bool:
	if not event is InputEventJoypadButton: return false

	var action = event.as_text()
	if !action.match("*Joypad*"): return false

	return action.match("*Bottom Action*") || \
		action.match("*Top Action*") || \
		action.match("*Left Action*") || \
		action.match("*Right Action*") || \
		action.match("*Start*") || \
		action.match("*Sony Select*") || \
		action.match("*Sony L3*") || \
		action.match("*Sony R3*") || \
		action.match("*Sony L1*") || \
		action.match("*Sony R1*")
