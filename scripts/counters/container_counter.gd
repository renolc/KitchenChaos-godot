extends BaseCounter

@export var resource: KitchenObjectResource

@onready var sprite := $"ContainerCounterVisuals/ContainerCounter_Visual/ContainerCounter_Visual2/Single door/ObjectSprite/Sprite3D"

func _ready():
	sprite.texture = resource.sprite

func interact():
	var ko = resource.scene.instantiate() as KitchenObject
	ko.holder = Player.Instance
