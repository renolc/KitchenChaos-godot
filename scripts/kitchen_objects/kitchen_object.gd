class_name KitchenObject
extends Node3D

@export var sprite: Texture
@export var cuts_into: PackedScene
@export var cuts_required: int
@export var cooks_into: PackedScene
@export var cook_time: float
@export var can_be_plated: bool
@export var will_burn: bool

var holder

func try_set_holder(new_holder) -> bool:
	if !new_holder.has_method("set_kitchen_object"): return false

	var plated = false
	if new_holder.ko:
		if !new_holder.ko is Plate: return false
		if !(new_holder.ko as Plate).try_add_ingredient(self): return false
		plated = true

	if holder:
		holder.remove_kitchen_object()

	if plated: return true

	holder = new_holder
	holder.set_kitchen_object(self)
	position = Vector3.ZERO
	return true
