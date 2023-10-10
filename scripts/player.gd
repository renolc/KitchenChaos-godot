class_name Player
extends CharacterBody3D

@export var move_speed := 7.0
@export var rot_speed := 0.3

var is_walking := false

func _process(delta):
	var input_vector := Input.get_vector("left", "right", "up", "down")
	velocity = Vector3(input_vector.x, 0, input_vector.y) * move_speed
	is_walking = !velocity.is_equal_approx(Vector3.ZERO)
	if is_walking:
		rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z), rot_speed)
	move_and_slide()
