class_name ClearCounter
extends StaticBody3D

@export var resource: KitchenObjectResource

@onready var top_point := $CounterTopPoint

var ko: KitchenObject

func interact():
	if !ko:
		ko = resource.scene.instantiate()
		ko.position = top_point.position
		add_child(ko)
		print(ko.name)
