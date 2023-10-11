class_name BaseCounter
extends StaticBody3D

@onready var top_point := $CounterTopPoint

var ko: KitchenObject

func remove_kitchen_object():
	top_point.remove_child(ko)
	ko = null

func set_kitchen_object(v: KitchenObject):
	ko = v
	top_point.add_child(ko)

func has_kitchen_object() -> bool:
	return !!ko
