extends BaseCounter

signal item_dropped

func interact():
	if !ko:
		if Player.Instance.ko:
			Player.Instance.ko.try_set_holder(self)
	else:
		if ko is Plate && Player.Instance.ko:
			if (ko as Plate).try_add_ingredient(Player.Instance.ko):
				Player.Instance.remove_kitchen_object()
		else:
			ko.try_set_holder(Player.Instance)

func set_kitchen_object(v: KitchenObject):
	super(v)
	item_dropped.emit()
