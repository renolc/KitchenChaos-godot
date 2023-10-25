extends WorldCanvas

@export var ingredient_icon: PackedScene

@onready var container: FlowContainer = $SubViewport/FlowContainer

func ingredient_added(ko: KitchenObject):
	var icon: IngredientIcon = ingredient_icon.instantiate()
	icon.sprite = ko.sprite
	container.add_child(icon)
