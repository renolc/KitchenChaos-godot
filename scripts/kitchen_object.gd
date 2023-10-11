class_name KitchenObject
extends Node3D

var holder:
	set(v):
		if !v.has_method("set_kitchen_object"): return
		if v.has_kitchen_object(): return

		if holder:
			holder.remove_kitchen_object()

		holder = v
		holder.set_kitchen_object(self)
		position = Vector3.ZERO
