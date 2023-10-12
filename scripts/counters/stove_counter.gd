extends BaseCounter

signal cook_progress_update(progress)

var fry_timer: SceneTreeTimer

func _process(_delta):
	if fry_timer:
		cook_progress_update.emit(1 - (fry_timer.time_left / ko.cook_time))

func interact():
	if !has_kitchen_object():
		if Player.Instance.has_kitchen_object() && Player.Instance.ko.cooks_into:
			Player.Instance.ko.holder = self
			start_cooking()
	elif !Player.Instance.has_kitchen_object():
		ko.holder = Player.Instance
		cook_progress_update.emit(0)
		if fry_timer && fry_timer.time_left > 0:
			fry_timer.timeout.disconnect(finished_cooking)
			fry_timer.timeout.emit()
			fry_timer = null

func start_cooking():
	if ko.cooks_into:
		fry_timer = get_tree().create_timer(ko.cook_time)
		fry_timer.timeout.connect(finished_cooking)

func finished_cooking():
	fry_timer = null
	cook_progress_update.emit(0)
	var new_ko := ko.cooks_into.instantiate() as KitchenObject
	remove_kitchen_object(true)
	new_ko.holder = self
	start_cooking()
