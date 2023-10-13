extends Sprite3D

@onready var viewport: SubViewport = $SubViewport
@onready var grid: GridContainer = $SubViewport/GridContainer

func _ready():
	# there is currently a bug where viewport textures don't stick when
	# set in the editor:
	#   https://github.com/godotengine/godot/issues/66247
	RenderingServer.frame_post_draw.connect(func():
		texture = viewport.get_texture()
	)

func ingredient_added(ko: KitchenObject):
	var tex_rect := TextureRect.new()
	tex_rect.texture = ko.sprite
	tex_rect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL
	tex_rect.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	tex_rect.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	tex_rect.custom_minimum_size = Vector2(37, 37)
	grid.add_child(tex_rect)
