class_name Plate
extends KitchenObject

signal ingredient_added(ko)

var added_ingredients: Array[KitchenObject] = []

func try_add_ingredient(ko: KitchenObject) -> bool:
	if !ko.can_be_plated: return false
	if added_ingredients.any(func(i): return i.name == ko.name): return false

	added_ingredients.push_back(ko)
	ingredient_added.emit(ko)
	return true
