extends Node

@onready var valid_joypad_keys = {
	JOY_BUTTON_Y: preload("res://textures/joypad/face_top.png"),
	JOY_BUTTON_A: preload("res://textures/joypad/face_bottom.png"),
	JOY_BUTTON_X: preload("res://textures/joypad/face_left.png"),
	JOY_BUTTON_B: preload("res://textures/joypad/face_right.png"),
	JOY_BUTTON_START: preload("res://textures/joypad/start.png"),
	JOY_BUTTON_BACK: preload("res://textures/joypad/select.png"),
	JOY_BUTTON_LEFT_SHOULDER: preload("res://textures/joypad/l1.png"),
	JOY_BUTTON_RIGHT_SHOULDER: preload("res://textures/joypad/r1.png")
}

const DEFAULT_JOYPAD_BINDINGS = {
	"gamepad_interact": JOY_BUTTON_A,
	"gamepad_interact_alt": JOY_BUTTON_X,
	"gamepad_pause": JOY_BUTTON_START
}

var joypad_bindings = DEFAULT_JOYPAD_BINDINGS.duplicate()

func get_movement_vector() -> Vector2:
	var keyboard_vector := Input.get_vector("left", "right", "up", "down")
	var gamepad_vector := Input.get_vector("gamepad_left", "gamepad_right", "gamepad_up", "gamepad_down")

	if keyboard_vector.length() > gamepad_vector.length():
		return keyboard_vector

	return gamepad_vector

func get_right_stick_x_axis() -> float:
	return Input.get_axis("ui_focus_left", "ui_focus_right")

func interact_just_pressed() -> bool:
	return Input.is_action_just_pressed("interact") || JoypadManager.just_pressed(joypad_bindings["gamepad_interact"])

func interact_alt_just_pressed() -> bool:
	return Input.is_action_just_pressed("interact_alt") || JoypadManager.just_pressed(joypad_bindings["gamepad_interact_alt"])

func paused_just_pressed() -> bool:
	return Input.is_action_just_pressed("pause") || JoypadManager.just_pressed(joypad_bindings["gamepad_pause"])

func update_button(btn: KeymapButton):
	if btn.is_joypad:
		btn.icon = get_joypad_icon(btn.action)
	else:
		var action_name = InputMap.action_get_events(btn.action)[0].as_text()
		btn.text = action_name.split(" ")[0].to_upper()

func get_joypad_icon(joy_action: String) -> Texture:
	var joy_buton = joypad_bindings[joy_action]

	for i in valid_joypad_keys:
		if i == joy_buton:
			return valid_joypad_keys[i]

	return

func is_valid_joypad_event(event: InputEvent) -> bool:
	if not event is InputEventJoypadButton: return false

	var action = event.as_text()
	if !action.match("*Joypad*"): return false

	var event_button_idx := (event as InputEventJoypadButton).button_index
	return valid_joypad_keys.keys().any(func(key):
		return key == event_button_idx
	)

func get_joypad_button_text(btn: KeymapButton) -> String:
	return str(joypad_bindings[btn.action])

func reset_all_bindings():
	InputMap.load_from_project_settings()
	joypad_bindings = DEFAULT_JOYPAD_BINDINGS.duplicate()
