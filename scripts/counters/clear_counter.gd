class_name ClearCounter
extends StaticBody3D

@export var resource: KitchenObjectResource

@onready var top_point := $CounterTopPoint

func interact():
	var ko := resource.scene.instantiate()
	ko.position = top_point.position
	add_child(ko)
