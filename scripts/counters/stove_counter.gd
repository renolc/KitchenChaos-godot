extends BaseCounter

@onready var audio_player: AudioStreamPlayer3D = $StoveSoundPlayer
@onready var progress_anim_player: AnimationTree = $Progress/AnimationTree
@onready var warning_icon_anim_player: AnimationTree = $BurnWarningIcon/AnimationTree
@onready var burn_warning_sfx_timer: Timer = $BurnWarningSfxTimer

signal cook_progress_update(progress)

var fry_timer: SceneTreeTimer
var is_burning = false:
	set(v):
		if is_burning == v: return
		is_burning = v

		progress_anim_player["parameters/conditions/is_burning"] = is_burning
		progress_anim_player["parameters/conditions/is_not_burning"] = !is_burning

		warning_icon_anim_player["parameters/conditions/is_burning"] = is_burning
		warning_icon_anim_player["parameters/conditions/is_not_burning"] = !is_burning

		if is_burning:
			burn_warning_sfx_timer.start()
		else:
			burn_warning_sfx_timer.stop()

func _process(_delta):
	if fry_timer:
		var progress = 1 - (fry_timer.time_left / ko.cook_time)
		is_burning = ko.will_burn && progress > .5
		cook_progress_update.emit(progress)

func reset_cook_progress():
	is_burning = false
	cook_progress_update.emit(0)

func interact():
	if !ko:
		if Player.Instance.ko && Player.Instance.ko.cooks_into:
			if Player.Instance.ko.try_set_holder(self):
				start_cooking()
	else:
		if ko.try_set_holder(Player.Instance):
			reset_cook_progress()
			audio_player.stop()
			if fry_timer && fry_timer.time_left > 0:
				fry_timer.timeout.disconnect(finished_cooking)
				fry_timer.timeout.emit()
				fry_timer = null

func start_cooking():
	if ko.cooks_into:
		audio_player.play()
		fry_timer = get_tree().create_timer(ko.cook_time, false)
		fry_timer.timeout.connect(finished_cooking)

func finished_cooking():
	fry_timer = null
	reset_cook_progress()
	var new_ko := ko.cooks_into.instantiate() as KitchenObject
	remove_kitchen_object(true)
	if new_ko.try_set_holder(self):
		start_cooking()
		if !new_ko.cooks_into:
			audio_player.stop()
