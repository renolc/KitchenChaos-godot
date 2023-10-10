class_name Player
extends CharacterBody3D

@export var move_speed := 7.0
@export var rot_speed := 0.3

@onready var ray_cast := $RayCast3D

signal selected_counter_changed(counter)

static var Instance: Player

var is_walking := false
var selected_counter: ClearCounter:
	set(c):
		if selected_counter != c: selected_counter_changed.emit(c)
		selected_counter = c

func _init():
	Instance = self

func _process(_delta):
	handle_movement()
	update_selected_counter()
	handle_interact()

func handle_movement():
	var input_vector := Input.get_vector("left", "right", "up", "down")
	velocity = Vector3(input_vector.x, 0, input_vector.y) * move_speed
	is_walking = !velocity.is_equal_approx(Vector3.ZERO)
	if is_walking:
		rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z), rot_speed)
	move_and_slide()

func update_selected_counter():
	selected_counter = ray_cast.get_collider()

func handle_interact():
	if !Input.is_action_just_pressed("interact"): return
	if selected_counter == null: return
	if !selected_counter.has_method("interact"): return

	selected_counter.interact()
