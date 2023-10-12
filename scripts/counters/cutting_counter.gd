extends BaseCounter

var cutting_progress := 0

func interact():
	if !ko:
		if Player.Instance.has_kitchen_object():
			Player.Instance.ko.holder = self
			cutting_progress = 0
	else:
		ko.holder = Player.Instance

func interact_alt():
	if !ko || !ko.cuts_into: return

	cutting_progress += 1

	if cutting_progress >= ko.cuts_required:
		var new_ko := ko.cuts_into.instantiate() as KitchenObject
		remove_kitchen_object(true)
		new_ko.holder = self
