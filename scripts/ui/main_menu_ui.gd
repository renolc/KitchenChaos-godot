extends Control

@export_file("*.tscn") var game_scene_path

@onready var loading_screen: ColorRect = $LoadingScreen

func _ready():
	get_tree().paused = false
	ResourceLoader.load_threaded_request(game_scene_path)

func play_pressed():
	loading_screen.visible = true
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(game_scene_path))

func quit_pressed():
	get_tree().quit()
