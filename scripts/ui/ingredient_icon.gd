class_name IngredientIcon
extends TextureRect

@onready var icon: TextureRect = $IconRect

var sprite: Texture:
	set(v):
		await ready
		icon.texture = v
