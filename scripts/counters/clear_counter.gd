class_name ClearCounter
extends StaticBody3D

@export var resource: KitchenObjectResource

@onready var top_point := $CounterTopPoint

var ko: KitchenObject

func interact():
	if !ko:
		var o = resource.scene.instantiate() as KitchenObject
		o.holder = self
	else:
		ko.holder = Player.Instance

func remove_kitchen_object():
	top_point.remove_child(ko)
	ko = null

func set_kitchen_object(v: KitchenObject):
	ko = v
	top_point.add_child(ko)

func has_kitchen_object() -> bool:
	return !!ko
