extends ProgressBar

var mouse_down = false

func _gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		var e : InputEventMouseButton = event
		if e.button_index == MOUSE_BUTTON_LEFT:
			mouse_down = e.pressed

	if mouse_down && event is InputEventMouseMotion:
		var e : InputEventMouseMotion = event
		value += e.relative.x / 100.0
