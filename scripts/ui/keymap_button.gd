class_name KeymapButton
extends Button

@export var action: String

signal bind_pressed(btn)

func _ready():
	update_text()

func _pressed():
	bind_pressed.emit(self)

func update_text():
	text = InputManager.get_key_text_from_action(action)
