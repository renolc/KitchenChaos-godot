class_name WorldCanvas
extends Sprite3D

@onready var viewport: SubViewport = $SubViewport

func _ready():
	# there is currently a bug where viewport textures don't stick when
	# set in the editor:
	#   https://github.com/godotengine/godot/issues/66247
	RenderingServer.frame_post_draw.connect(func():
		texture = viewport.get_texture()
	)
