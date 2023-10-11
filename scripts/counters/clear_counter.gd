class_name ClearCounter
extends StaticBody3D

@export var resource: KitchenObjectResource

@onready var top_point := $CounterTopPoint

var ko: KitchenObject

func interact():
	if !ko:
		if Player.Instance.has_kitchen_object():
			Player.Instance.ko.holder = self
		else:
			var new_ko = resource.scene.instantiate() as KitchenObject
			new_ko.holder = self
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
