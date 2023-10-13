extends BaseCounter

func interact():
	if !ko:
		if Player.Instance.ko:
			Player.Instance.ko.try_set_holder(self)
	else:
		if ko.is_plate() && Player.Instance.ko:
			if (ko as Plate).try_add_ingredient(Player.Instance.ko):
				Player.Instance.remove_kitchen_object()
		else:
			ko.try_set_holder(Player.Instance)
