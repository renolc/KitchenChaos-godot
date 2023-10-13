extends BaseCounter

func interact():
	if !Player.Instance.ko || !Player.Instance.ko.is_plate(): return

	Player.Instance.remove_kitchen_object(true)
