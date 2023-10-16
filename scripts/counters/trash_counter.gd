extends BaseCounter

signal item_trashed

func interact():
	if Player.Instance.ko:
		Player.Instance.remove_kitchen_object(true)
		item_trashed.emit()
