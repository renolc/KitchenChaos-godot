extends Sprite3D

@export var ingredient_icon: PackedScene

@onready var viewport: SubViewport = $SubViewport
@onready var hbox1: HBoxContainer = $SubViewport/VBoxContainer/HBoxContainer
@onready var hbox2: HBoxContainer = $SubViewport/VBoxContainer/HBoxContainer2

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
	if hbox1.get_child_count() < 3:
		hbox1.add_child(icon)
	else:
		hbox2.add_child(icon)
