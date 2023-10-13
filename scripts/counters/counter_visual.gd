class_name CounterVisual
extends Node

@export var mesh_array: Array[MeshInstance3D]

var selected_material: Material = preload("res://materials/counter_selected.tres")

func _ready():
	var counter = get_parent()
	Player.Instance.selected_counter_changed.connect(func(selected):
		for i in mesh_array:
			i.material_overlay = selected_material if selected == counter else null
	)
