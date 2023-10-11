extends BaseCounter

@export var resource: KitchenObjectResource

func interact():
	var ko = resource.scene.instantiate() as KitchenObject
	ko.holder = Player.Instance
