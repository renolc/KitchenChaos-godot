class_name CounterVisual
extends Node

@export var counter: BaseCounter

@onready var selected := $Selected

func _ready():
	Player.Instance.selected_counter_changed.connect(func(i):
		selected.visible = i == counter
	)
