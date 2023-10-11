extends BaseCounter

var ko: KitchenObject

func interact():
	if !ko:
		if Player.Instance.has_kitchen_object():
			Player.Instance.ko.holder = self
	else:
		ko.holder = Player.Instance

func remove_kitchen_object():
	self.top_point.remove_child(ko)
	ko = null

func set_kitchen_object(v: KitchenObject):
	ko = v
	self.top_point.add_child(ko)

func has_kitchen_object() -> bool:
	return !!ko
