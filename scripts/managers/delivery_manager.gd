class_name DeliveryManager
extends Node

@export var recipes: Array[RecipeResource]

signal new_order_added(recipe)
signal order_delivered(recipe)

static var Instance: DeliveryManager

const MAX_ORDERS = 4

var waiting_recipes: Array[RecipeResource]

func _init():
	randomize()
	Instance = self

func add_new_order():
	if waiting_recipes.size() < MAX_ORDERS:
		var order_recipe: RecipeResource = recipes.pick_random()
		waiting_recipes.push_back(order_recipe)
		new_order_added.emit(order_recipe)

func deliver_recipe(plate: Plate):
	var matching_recipe: RecipeResource

	for recipe in waiting_recipes:
		if recipe.ingredients.size() != plate.added_ingredients.size(): continue
		if recipe.ingredients.all(func(ingredient):
			return plate.added_ingredients.any(
				func(i): return i.name == recipe.ingredient_name(ingredient)
			)
		):
			matching_recipe = recipe
			break

	if matching_recipe:
		waiting_recipes.erase(matching_recipe)
		order_delivered.emit(matching_recipe)
	else:
		print("no match")
