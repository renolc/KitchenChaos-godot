extends CounterVisual

@onready var delivery_arrow: MeshInstance3D = $DeliveryCounter_Visual/DeliveryCounter_Visual2/KitchenCounter/DeliveryArrow

var time = 0.0

func _process(_delta):
	time += _delta
	time = fmod(time, 1)
	(delivery_arrow.get_active_material(0) as ShaderMaterial).set_shader_parameter("Time", time)
