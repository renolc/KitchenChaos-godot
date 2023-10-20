class_name KeymapButton
extends Button

@export var action: String

signal bind_pressed(btn)

func _ready():
	update_text()

func _pressed():
	bind_pressed.emit(self)

func update_text():
	text = InputMap \
		.action_get_events(action)[0] \
		.as_text() \
		.split(" ")[0] \
		.to_upper()
