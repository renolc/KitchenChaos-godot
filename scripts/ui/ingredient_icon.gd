class_name IngredientIcon
extends TextureRect

@onready var icon: TextureRect = $IconRect

var sprite: Texture:
	set(v):
		# not sure if a godot bug, but it keeps hitting this function
		# before _ready runs, so icon is null
		await ready
		icon.texture = v
