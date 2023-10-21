extends Control

@export var options_menu: Control

@onready var resume_btn: Button = $ResumeButton

func _ready():
	visibility_changed.connect(func():
		if visible: focus()
	)
	options_menu.visibility_changed.connect(func():
		if !options_menu.visible: focus()
	)

func focus():
	resume_btn.grab_focus()

func paused_changed(paused: bool):
	visible = paused

func resume_pressed():
	GameManager.Instance.toggle_pause()

func menu_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu_scene.tscn")

func options_pressed():
	options_menu.show()
