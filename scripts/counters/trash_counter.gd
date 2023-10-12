extends BaseCounter

func interact():
	if Player.Instance.has_kitchen_object():
		Player.Instance.ko.queue_free()
