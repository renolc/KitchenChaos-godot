class_name ClearCounter
extends StaticBody3D

@export var resource: KitchenObjectResource

@onready var top_point := $CounterTopPoint

var ko: KitchenObject:
	set(v):
		ko = v
		if ko:
			top_point.add_child(ko)

func interact():
	if !ko:
		ko = resource.scene.instantiate() as KitchenObject
		ko.counter = self
	else:
		pass

func remove_kitchen_object():
	top_point.remove_child(ko)
	ko = null
