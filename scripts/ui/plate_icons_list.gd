extends Sprite3D

@export var ingredient_icon: PackedScene

@onready var viewport: SubViewport = $SubViewport
@onready var container: FlowContainer = $SubViewport/FlowContainer

func _ready():
	# there is currently a bug where viewport textures don't stick when
	# set in the editor:
	#   https://github.com/godotengine/godot/issues/66247
	RenderingServer.frame_post_draw.connect(func():
		texture = viewport.get_texture()
	)

func ingredient_added(ko: KitchenObject):
	var icon: IngredientIcon = ingredient_icon.instantiate()
	icon.sprite = ko.sprite
	container.add_child(icon)
