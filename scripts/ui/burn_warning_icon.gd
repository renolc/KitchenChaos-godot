extends Sprite3D

var counter: BaseCounter

func _ready():
	counter = get_parent()

func cook_progress_update(progress: float):
	if counter.ko && counter.ko.will_burn && progress > .5:
		show()
	else:
		hide()
