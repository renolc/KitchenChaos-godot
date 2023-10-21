extends ProgressBar

var mouse_down = false

func _ready():
	focus_entered.connect(func():
		self["theme_override_styles/background"].border_width_left = 2
		self["theme_override_styles/background"].border_width_top = 2
		self["theme_override_styles/background"].border_width_right = 2
		self["theme_override_styles/background"].border_width_bottom = 2
	)

	focus_exited.connect(func():
		self["theme_override_styles/background"].border_width_left = 0
		self["theme_override_styles/background"].border_width_top = 0
		self["theme_override_styles/background"].border_width_right = 0
		self["theme_override_styles/background"].border_width_bottom = 0
	)

func _process(_delta):
	if !has_focus(): return

	value += InputManager.get_right_stick_x_axis() / 20

func _gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		var e : InputEventMouseButton = event
		if e.button_index == MOUSE_BUTTON_LEFT:
			mouse_down = e.pressed

	if mouse_down && event is InputEventMouseMotion:
		var e : InputEventMouseMotion = event
		value += e.relative.x / 100.0
