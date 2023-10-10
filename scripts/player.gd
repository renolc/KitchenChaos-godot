class_name Player
extends CharacterBody3D

@export var move_speed := 7.0
@export var rot_speed := 0.3

@onready var ray_cast := $RayCast3D

var is_walking := false

func _process(_delta):
	handle_movement()
	handle_interact()

func handle_movement():
	var input_vector := Input.get_vector("left", "right", "up", "down")
	velocity = Vector3(input_vector.x, 0, input_vector.y) * move_speed
	is_walking = !velocity.is_equal_approx(Vector3.ZERO)
	if is_walking:
		rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z), rot_speed)
	move_and_slide()

func handle_interact():
	if !Input.is_action_just_pressed("interact"): return

	var other = ray_cast.get_collider()
	if other && other.has_method("interact"):
		other.interact()
