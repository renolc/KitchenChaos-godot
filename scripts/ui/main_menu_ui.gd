extends Control

@export_file("*.tscn") var game_scene_path

@onready var loading_screen: ColorRect = $LoadingScreen
@onready var play_btn: Button = $PlayButton
@onready var quit_btn: Button = $QuitButton
@onready var loading_label: Label = $LoadingScreen/LoadingLabel

func _ready():
	get_tree().set_auto_accept_quit(false)
	get_tree().paused = false
	ResourceLoader.load_threaded_request(game_scene_path, "PackedScene", true)
	play_btn.grab_focus()

func play_pressed():
	play_btn.release_focus()
	loading_screen.show()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(game_scene_path))

func quit_pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	loading_label.text = "Cleaning up..."
	loading_screen.show()
	play_btn.disabled = true
	quit_btn.disabled = true

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		while ResourceLoader.load_threaded_get_status(game_scene_path) == 1:
			await get_tree().create_timer(0.1).timeout
		get_tree().quit()
