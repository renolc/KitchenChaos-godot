class_name RecipeResource
extends Resource

@export var name: String
@export var ingredients: Array[PackedScene]

func ingredient_name(ingredient: PackedScene) -> String:
	var i = ingredients.find(ingredient)
	return ingredients[i].get_state().get_node_name(0)

func ingredient_sprite(ingredient: PackedScene) -> Texture:
	var i = ingredients.find(ingredient)
	return ingredients[i].get_state().get_node_property_value(0, 1)
