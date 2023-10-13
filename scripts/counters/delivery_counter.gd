extends BaseCounter

func interact():
	if !Player.Instance.ko || !Player.Instance.ko.is_plate(): return

	DeliveryManager.Instance.deliver_recipe(Player.Instance.ko)
	Player.Instance.remove_kitchen_object(true)
