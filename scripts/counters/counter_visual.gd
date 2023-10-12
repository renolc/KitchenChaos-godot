class_name CounterVisual
extends Node

@onready var selected := $Selected

func _ready():
	var counter = get_parent()
	Player.Instance.selected_counter_changed.connect(func(i):
		selected.visible = i == counter
	)
