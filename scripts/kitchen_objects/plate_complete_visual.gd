extends Node

@onready var bread = $PlateCompleteVisual/PlateCompleteVisual2/Bread
@onready var meat = $PlateCompleteVisual/PlateCompleteVisual2/MeatPattyCooked
@onready var tomato = $PlateCompleteVisual/PlateCompleteVisual2/TomatoSlices
@onready var cheese = $PlateCompleteVisual/PlateCompleteVisual2/CheeseSlices
@onready var cabbage = $PlateCompleteVisual/PlateCompleteVisual2/CabbageSliced

var name_to_node: Dictionary

func _ready():
	name_to_node = {
		Bread = bread,
		MeatCooked = meat,
		TomatoCut = tomato,
		CheeseCut = cheese,
		CabbageCut = cabbage
	}

	for i in name_to_node:
		name_to_node[i].visible = false

func ingredient_added(ko: KitchenObject):
	print(ko.name)
	name_to_node[ko.name].visible = true
