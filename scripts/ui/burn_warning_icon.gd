extends Sprite3D

var counter: BaseCounter

func _ready():
	counter = get_parent()

func cook_progress_update(progress: float):
	if counter.ko && counter.ko.will_burn && progress > .5:
		if !visible:
			show()
			flash()
	else:
		hide()

func flash():
	var alpha: float = modulate.a
	alpha = fmod(alpha + 1, 2.0)
	await create_tween().tween_property(self, "modulate:a", alpha, 1/6.0).finished
	if visible: flash()
