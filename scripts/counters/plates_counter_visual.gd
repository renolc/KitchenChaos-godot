extends CounterVisual

@export var top_point: Node3D
@export var plate_visual_scene: PackedScene

var plates := []

func plate_spawned():
	var plate: Node3D = plate_visual_scene.instantiate()
	top_point.add_child(plate)

	plate.position.y = 0.1 * plates.size()
	plates.push_back(plate)

func plate_removed():
	var plate: Node3D = plates.pop_back()
	plate.queue_free()
