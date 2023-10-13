extends BaseCounter

func interact():
	if Player.Instance.ko:
		Player.Instance.ko.queue_free()
