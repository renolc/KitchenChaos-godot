extends BaseCounter

var fry_timer: SceneTreeTimer

func interact():
	if !ko:
		if Player.Instance.has_kitchen_object() && Player.Instance.ko.cooks_into:
			Player.Instance.ko.holder = self
			start_cooking()
	else:
		ko.holder = Player.Instance
		if fry_timer.time_left > 0:
			fry_timer.timeout.disconnect(finished_cooking)
			fry_timer.timeout.emit()
			fry_timer = null

func start_cooking():
	if ko.cooks_into:
		fry_timer = get_tree().create_timer(ko.cook_time)
		fry_timer.timeout.connect(finished_cooking)

func finished_cooking():
	var new_ko := ko.cooks_into.instantiate() as KitchenObject
	remove_kitchen_object(true)
	new_ko.holder = self
	start_cooking()
