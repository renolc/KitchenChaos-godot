extends BaseCounter

@onready var audio_player: AudioStreamPlayer3D = $StoveSoundPlayer

signal cook_progress_update(progress)

var fry_timer: SceneTreeTimer

func _process(_delta):
	if fry_timer:
		cook_progress_update.emit(1 - (fry_timer.time_left / ko.cook_time))

func interact():
	if !ko:
		if Player.Instance.ko && Player.Instance.ko.cooks_into:
			if Player.Instance.ko.try_set_holder(self):
				start_cooking()
	else:
		if ko.try_set_holder(Player.Instance):
			cook_progress_update.emit(0)
			audio_player.stop()
			if fry_timer && fry_timer.time_left > 0:
				fry_timer.timeout.disconnect(finished_cooking)
				fry_timer.timeout.emit()
				fry_timer = null

func start_cooking():
	if ko.cooks_into:
		audio_player.play()
		fry_timer = get_tree().create_timer(ko.cook_time)
		fry_timer.timeout.connect(finished_cooking)

func finished_cooking():
	fry_timer = null
	cook_progress_update.emit(0)
	var new_ko := ko.cooks_into.instantiate() as KitchenObject
	remove_kitchen_object(true)
	if new_ko.try_set_holder(self):
		start_cooking()
		if !new_ko.cooks_into:
			audio_player.stop()
