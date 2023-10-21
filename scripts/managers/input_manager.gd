extends Node

func get_movement_vector() -> Vector2:
	var keyboard_vector := Input.get_vector("left", "right", "up", "down")
	var gamepad_vector := Input.get_vector("gamepad_left", "gamepad_right", "gamepad_up", "gamepad_down")

	if keyboard_vector.length() > gamepad_vector.length():
		return keyboard_vector

	return gamepad_vector

func interact_just_pressed() -> bool:
	return Input.is_action_just_pressed("interact") || Input.is_action_just_pressed("gamepad_interact")

func interact_alt_just_pressed() -> bool:
	return Input.is_action_just_pressed("interact_alt") || Input.is_action_just_pressed("gamepad_interact_alt")

func paused_just_pressed() -> bool:
	return Input.is_action_just_pressed("pause") || Input.is_action_just_pressed("gamepad_pause")
