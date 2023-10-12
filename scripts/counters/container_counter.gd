class_name ContainerCounter
extends BaseCounter

@export var scene: PackedScene

signal player_grabbed_object

func interact():
	if Player.Instance.has_kitchen_object(): return

	var new_ko = scene.instantiate() as KitchenObject
	new_ko.holder = Player.Instance
	player_grabbed_object.emit()
