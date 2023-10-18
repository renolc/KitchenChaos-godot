extends Control

func play_pressed():
	get_tree().change_scene_to_file("res://scenes/game_scene.tscn")

func quit_pressed():
	get_tree().quit()
