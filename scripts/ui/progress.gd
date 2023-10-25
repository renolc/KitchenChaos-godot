extends WorldCanvas

@onready var bar: TextureProgressBar = $SubViewport/TextureProgressBar

func _ready():
	super()
	hide()

func progress_updated(v: float):
	bar.value = v
	visible = v > 0 && v < 1
	if bar.value >= 1: bar.value = 0
