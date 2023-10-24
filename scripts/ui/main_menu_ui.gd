extends Control

@export_file("*.tscn") var game_scene_path

@onready var loading_screen: ColorRect = $LoadingScreen
@onready var play_btn: Button = $PlayButton

func _ready():
	get_tree().paused = false
	play_btn.grab_focus()

func play_pressed():
	loading_screen.show()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file(game_scene_path)

func quit_pressed():
	get_tree().quit()
