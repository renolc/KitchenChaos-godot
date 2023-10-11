class_name ContainerCounter
extends BaseCounter

@export var scene: PackedScene

@onready var sprite := $"ContainerCounterVisuals/ContainerCounter_Visual/ContainerCounter_Visual2/Single door/ObjectSprite/Sprite3D"

signal player_grabbed_object

func _ready():
	if !scene: return

	var tmp := scene.instantiate() as KitchenObject
	sprite.texture = tmp.sprite
	tmp.queue_free()

func interact():
	if Player.Instance.has_kitchen_object(): return

	var new_ko = scene.instantiate() as KitchenObject
	new_ko.holder = Player.Instance
	player_grabbed_object.emit()
