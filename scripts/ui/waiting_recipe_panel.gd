class_name RecipePanel
extends Panel

@export var recipe_icon: PackedScene

@onready var name_label: Label = $Name
@onready var icons_list: HBoxContainer = $IconsList

var recipe: RecipeResource:
	set(v):
		await ready
		recipe = v
		name_label.text = recipe.name

		for i in recipe.ingredients:
			var icon: TextureRect = recipe_icon.instantiate()
			icon.texture = recipe.ingredient_sprite(i)
			icons_list.add_child(icon)
