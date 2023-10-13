class_name CuttingCounter
extends BaseCounter

signal cut_progress_update(progress)
signal cut_performed

var cutting_progress := 0:
	set(v):
		cutting_progress = v
		var progress = 0.0 if !ko else float(cutting_progress) / ko.cuts_required
		cut_progress_update.emit(progress)

func interact():
	if !ko:
		if Player.Instance.ko && Player.Instance.ko.cuts_into:
			Player.Instance.ko.holder = self
			cutting_progress = 0
	else:
		ko.holder = Player.Instance
		cutting_progress = 0

func interact_alt():
	if !ko || !ko.cuts_into: return

	cutting_progress += 1
	cut_performed.emit()

	if cutting_progress >= ko.cuts_required:
		var new_ko := ko.cuts_into.instantiate() as KitchenObject
		remove_kitchen_object(true)
		new_ko.holder = self
