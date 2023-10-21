extends Control

@export var options_menu: Control

func paused_changed(paused: bool):
	visible = paused

func resume_pressed():
	GameManager.Instance.toggle_pause()

func menu_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu_scene.tscn")

func options_pressed():
	options_menu.show()
