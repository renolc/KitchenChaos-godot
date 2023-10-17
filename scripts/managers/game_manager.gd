class_name GameManager
extends Node

const WAIT_TO_START_TIME = 1
const COUNTDOWN_TIME = 3
const PLAYING_TIME = 10

static var Instance: GameManager

enum State {
	WaitingToStart,
	Countdown,
	Playing,
	GameOver
}

var state: State:
	set(s):
		state = s
		print(State.keys()[state])
		call(State.keys()[state])

func _init():
	Instance = self

func _ready():
	state = State.WaitingToStart

func WaitingToStart():
	await get_tree().create_timer(WAIT_TO_START_TIME).timeout
	state = State.Countdown

func Countdown():
	await get_tree().create_timer(COUNTDOWN_TIME).timeout
	state = State.Playing

func Playing():
	await get_tree().create_timer(PLAYING_TIME).timeout
	state = State.GameOver

func GameOver():
	pass

func is_game_playing() -> bool:
	return state == State.Playing
