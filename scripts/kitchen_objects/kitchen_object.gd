class_name KitchenObject
extends Node3D

@export var sprite: Texture
@export var cuts_into: PackedScene
@export var cuts_required: int
@export var cooks_into: PackedScene
@export var cook_time: float
@export var can_be_plated: bool

var holder:
	set(new_holder):
		if !new_holder.has_method("set_kitchen_object"): return

		var plated = false
		if new_holder.has_kitchen_object():
			if !new_holder.ko.is_plate(): return

			if !(new_holder.ko as Plate).try_add_ingredient(self): return
			else: plated = true

		if holder:
			holder.remove_kitchen_object()

		if plated: return

		holder = new_holder
		holder.set_kitchen_object(self)
		position = Vector3.ZERO

func is_plate() -> bool:
	return name == "Plate"
