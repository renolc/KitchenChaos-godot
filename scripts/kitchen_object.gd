class_name KitchenObject
extends Node3D

var counter: ClearCounter:
	set(v):
		if counter:
			counter.remove_kitchen_object()
		counter = v
		counter.ko = self
		position = Vector3.ZERO
