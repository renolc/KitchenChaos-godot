class_name BaseCounter
extends StaticBody3D

@onready var top_point := $CounterTopPoint

var ko: KitchenObject

func remove_kitchen_object(del_ko: bool = false):
	top_point.remove_child(ko)
	if del_ko: ko.queue_free()
	ko = null

func set_kitchen_object(v: KitchenObject):
	ko = v
	top_point.add_child(ko)
