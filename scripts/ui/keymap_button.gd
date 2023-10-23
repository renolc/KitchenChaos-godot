class_name KeymapButton
extends Button

@export var action: String
@export var is_joypad: bool
@export var options_ui: OptionsUI

signal bind_pressed(btn)

func _ready():
	update_text()

func _pressed():
	if !options_ui.binding_btn:
		bind_pressed.emit(self)

func update_text():
	InputManager.update_button(self)
