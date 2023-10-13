class_name Plate
extends KitchenObject

var added_ingredients: Array[KitchenObject] = []

func add_ingredient(ko: KitchenObject):
	added_ingredients.push_back(ko)
