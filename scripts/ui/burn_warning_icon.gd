extends Sprite3D

@onready var timer: Timer = $WarningTimer
@onready var sfx_player: SfxManager = $WarningSfxManager

var counter: BaseCounter

func _ready():
	counter = get_parent()

func cook_progress_update(_progress: float):
	if counter.is_burning:
		if !visible:
			show()
			flash()
			timer.start()
	else:
		hide()
		timer.stop()

func flash():
	var alpha: float = modulate.a
	alpha = fmod(alpha + 1, 2.0)
	await create_tween().tween_property(self, "modulate:a", alpha, 1/6.0).finished
	if visible: flash()
