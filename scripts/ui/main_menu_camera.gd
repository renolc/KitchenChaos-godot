extends Camera3D

var og_rotation: Vector3

func _ready():
	randomize()
	og_rotation = rotation
	random_rotate("x")
	random_rotate("y")

func random_rotate(prop):
	var max_offset = 0.1
	if prop == "x": max_offset /= 2
	var target = randf() * max_offset - (max_offset/2)
	var time = randf_range(2.5, 5)

	await create_tween() \
		.set_trans(Tween.TRANS_SINE) \
		.tween_property(self, "rotation:" + prop, og_rotation[prop] + target, time) \
		.finished

	random_rotate(prop)
