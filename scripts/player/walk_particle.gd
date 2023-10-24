extends GPUParticles3D

@export var min_distance = 0.4

@onready var previous_position = global_position

var distance_accum = 0.0

func _process(_delta):
	distance_accum = distance_accum + previous_position.distance_to(global_position)

	while distance_accum >= min_distance:
		emit_particle(transform, position, Color.WHITE, Color.WHITE, 0)
		distance_accum -= min_distance

	previous_position = global_position
