class_name ContainerCounter
extends BaseCounter

@export var resource: KitchenObjectResource

@onready var sprite := $"ContainerCounterVisuals/ContainerCounter_Visual/ContainerCounter_Visual2/Single door/ObjectSprite/Sprite3D"

signal player_grabbed_object

func _ready():
	sprite.texture = resource.sprite

func interact():
	if Player.Instance.has_kitchen_object(): return

	var new_ko = resource.scene.instantiate() as KitchenObject
	new_ko.holder = Player.Instance
	player_grabbed_object.emit()
