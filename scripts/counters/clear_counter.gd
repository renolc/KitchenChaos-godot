extends BaseCounter

func interact():
	if !ko:
		if Player.Instance.ko:
			Player.Instance.ko.holder = self
	else:
		ko.holder = Player.Instance
