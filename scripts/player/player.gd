class_name Player
extends CharacterBody3D

@export var move_speed := 7.0
@export var rot_speed := 0.3

@onready var ray_cast := $RayCast3D
@onready var hold_point := $HoldPoint

signal selected_counter_changed(counter)
signal item_picked_up

static var Instance: Player

var ko: KitchenObject
var is_walking := false
var selected_counter: BaseCounter:
	set(c):
		if selected_counter != c: selected_counter_changed.emit(c)
		selected_counter = c

func _init():
	Instance = self

func _process(_delta):
	update_selected_counter()
	handle_movement()

func _unhandled_input(_event):
	handle_interact()

func get_movement_vector() -> Vector2:
	var keyboard_vector := Input.get_vector("left", "right", "up", "down")
	var gamepad_vector := Input.get_vector("gamepad_left", "gamepad_right", "gamepad_up", "gamepad_down")

	if keyboard_vector.length() > gamepad_vector.length():
		return keyboard_vector

	return gamepad_vector

func interact_just_pressed() -> bool:
	return Input.is_action_just_pressed("interact") || Input.is_action_just_pressed("gamepad_interact")

func interact_alt_just_pressed() -> bool:
	return Input.is_action_just_pressed("interact_alt") || Input.is_action_just_pressed("gamepad_interact_alt")

func handle_movement():
	var input_vector := get_movement_vector()
	velocity = Vector3(input_vector.x, 0, input_vector.y) * move_speed
	is_walking = !velocity.is_equal_approx(Vector3.ZERO)
	if is_walking:
		rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z), rot_speed)
	move_and_slide()

func update_selected_counter():
	selected_counter = ray_cast.get_collider()

func handle_interact():
	if GameManager.Instance.state != GameManager.State.Playing: return
	if !selected_counter: return

	if interact_just_pressed() && selected_counter.has_method("interact"):
		selected_counter.interact()

	if interact_alt_just_pressed() && selected_counter.has_method("interact_alt"):
		selected_counter.interact_alt()

func remove_kitchen_object(del_ko: bool = false):
	hold_point.remove_child(ko)
	if del_ko: ko.queue_free()
	ko = null

func set_kitchen_object(v: KitchenObject):
	ko = v
	hold_point.add_child(ko)
	item_picked_up.emit()
