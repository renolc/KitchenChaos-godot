extends BaseCounter

func interact():
	if !ko:
		if Player.Instance.has_kitchen_object():
			Player.Instance.ko.holder = self
	else:
		ko.holder = Player.Instance
