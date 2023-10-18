extends Node3D

@export var player: Player

@onready var animation_tree = $AnimationTree

const IS_WALKING = "parameters/conditions/is_walking"
const IS_IDLE = "parameters/conditions/is_idle"

func _ready():
	animation_tree.active = true

func _process(_delta):
	if player && player.is_walking:
		animation_tree[IS_IDLE] = false
		animation_tree[IS_WALKING] = true
	else:
		animation_tree[IS_WALKING] = false
		animation_tree[IS_IDLE] = true
