extends Node

var _just_pressed = {}

func _process(_delta):
	call_deferred("clear_just_pressed")

func _unhandled_input(event):
	if not event is InputEventJoypadButton: return

	var joy_event := event as InputEventJoypadButton
	var idx = joy_event.button_index

	if joy_event.pressed:
		_just_pressed[idx] = true

func clear_just_pressed():
	_just_pressed.clear()

func just_pressed(btn: JoyButton) -> bool:
	return !!_just_pressed.get(btn)
