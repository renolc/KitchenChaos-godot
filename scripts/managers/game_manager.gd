class_name GameManager
extends Node

const WAIT_TO_START_TIME = 1
const COUNTDOWN_TIME = 3
const PLAYING_TIME = 10

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
		print(State.keys()[state])
		call(State.keys()[state])

func _init():
	Instance = self

func _ready():
	state = State.WaitingToStart

func _unhandled_input(_event):
	if Input.is_action_just_pressed("pause"):
		toggle_pause()

func toggle_pause():
	var new_paused = !get_tree().paused
	get_tree().paused = new_paused
	paused_changed.emit(new_paused)

func WaitingToStart():
	timer = get_tree().create_timer(WAIT_TO_START_TIME, false)
	await timer.timeout
	state = State.Countdown

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
