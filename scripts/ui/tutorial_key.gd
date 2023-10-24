extends TextureRect

@export var action: String
@export var is_gamepad: bool

@onready var text: Label = $Text
@onready var icon: TextureRect = $Icon

func _ready():
	update_key()

	InputManager.action_updated.connect(func(i):
		if action == i: update_key()
	)

func update_key():
	if !action: return

	if is_gamepad:
		icon.texture = InputManager.get_joypad_icon(action)
	else:
		text.text = InputManager.get_action_button_text(action)
