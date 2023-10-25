extends Control

@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var countdown_sfx_player: SfxManager = $CountdownSfxManager

func show_number():
	label.text = str(ceil(GameManager.Instance.timer.time_left))
	animation_player.play("count")
	countdown_sfx_player.play_random()
	await animation_player.animation_finished
	if visible: show_number()

func state_changed(state: GameManager.State):
	if state == GameManager.State.Countdown:
		show()
		await get_tree().create_timer(0.1).timeout
		show_number()
	else:
		hide()
