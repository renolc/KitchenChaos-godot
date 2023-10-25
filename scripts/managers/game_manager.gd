class_name GameManager
extends Node

@export var options_menu: OptionsUI

const COUNTDOWN_TIME = 3
const PLAYING_TIME = 60

static var Instance: GameManager

signal state_changed(state)
signal paused_changed(is_paused)

enum State {
	WaitingToStart,
	Countdown,
	Playing,
	GameOver
}

var timer: SceneTreeTimer
var state: State:
	set(s):
		state = s
		state_changed.emit(state)
		call(State.keys()[state])

func _init():
	Instance = self

func _ready():
	state = State.WaitingToStart

func _process(_delta):
	if options_menu.key_prompt.visible: return

	if InputManager.paused_just_pressed():
		toggle_pause()

	if InputManager.interact_just_pressed():
		if !get_tree().paused && state == State.WaitingToStart:
			state = State.Countdown

func toggle_pause():
	var new_paused = !get_tree().paused
	get_tree().paused = new_paused
	paused_changed.emit(new_paused)

func WaitingToStart():
	pass

func Countdown():
	timer = get_tree().create_timer(COUNTDOWN_TIME, false)
	await timer.timeout
	state = State.Playing

func Playing():
	timer = get_tree().create_timer(PLAYING_TIME, false)
	await timer.timeout
	state = State.GameOver

func GameOver():
	pass
