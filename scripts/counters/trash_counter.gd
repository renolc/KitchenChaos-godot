extends BaseCounter

func interact():
	if Player.Instance.ko:
		Player.Instance.remove_kitchen_object(true)
