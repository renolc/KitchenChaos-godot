extends BaseCounter

func interact():
	if !ko:
		if Player.Instance.has_kitchen_object():
			Player.Instance.ko.holder = self
	else:
		ko.holder = Player.Instance

func interact_alt():
	if !ko || !ko.cuts_into: return

	var new_ko := ko.cuts_into.instantiate() as KitchenObject
	remove_kitchen_object(true)
	new_ko.holder = self
