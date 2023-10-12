extends Sprite3D

@onready var viewport: SubViewport = $SubViewport
@onready var bar: TextureProgressBar = $SubViewport/TextureProgressBar

func _ready() -> void:
	visible = false
	RenderingServer.frame_post_draw.connect(func():
		texture = viewport.get_texture()
	)

func progress_updated(v: float):
	bar.value = v
	visible = v > 0 && v < 1
	if bar.value >= 1: bar.value = 0
