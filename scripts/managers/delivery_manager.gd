class_name DeliveryManager
extends Node

@export var recipes: Array[RecipeResource]

static var Instance: DeliveryManager

const MAX_ORDERS = 4

var waiting_recipes: Array[RecipeResource]

func _init():
	randomize()
	Instance = self

func add_new_order():
	if waiting_recipes.size() < MAX_ORDERS:
		waiting_recipes.push_back(recipes.pick_random())
		print(waiting_recipes.back().name)

func deliver_recipe(plate: Plate):
	var matching_recipe: RecipeResource

	for recipe in waiting_recipes:
		if recipe.ingredients.size() != plate.added_ingredients.size(): continue
		if recipe.ingredients.all(func(ingredient):
			return plate.added_ingredients.any(func(i): return i.name == ingredient)
		):
			matching_recipe = recipe
			break


	if matching_recipe:
		print("match: ", matching_recipe.name)
		waiting_recipes.erase(matching_recipe)
	else:
		print("no match")



