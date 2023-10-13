@tool
class_name ContainerCounter
extends BaseCounter

@export var scene: PackedScene:
	# used to update the editor in realtime so we can
	# see the counter type without having to run the game
	set(v):
		scene = v
		if !Engine.is_editor_hint() || !visual: return
		visual.set_sprite(scene)

@onready var visual := $ContainerCounterVisuals

signal player_grabbed_object

func interact():
	if Player.Instance.ko: return

	var new_ko := scene.instantiate() as KitchenObject
	if new_ko.try_set_holder(Player.Instance):
		player_grabbed_object.emit()
