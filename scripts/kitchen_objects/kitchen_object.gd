class_name KitchenObject
extends Node3D

@export var sprite: Texture
@export var cuts_into: PackedScene
@export var cuts_required: int
@export var cooks_into: PackedScene
@export var cook_time: float

var holder:
	set(v):
		if !v.has_method("set_kitchen_object"): return
		if v.has_kitchen_object() && !v.ko.is_plate(): return

		if holder:
			holder.remove_kitchen_object()

		if v.has_kitchen_object() && v.ko.is_plate():
			(v.ko as Plate).add_ingredient(self)
			return

		holder = v
		holder.set_kitchen_object(self)
		position = Vector3.ZERO

func is_plate() -> bool:
	return name == "Plate"
