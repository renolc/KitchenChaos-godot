extends Node3D

@export var player: Player

@onready var animation_tree = $AnimationTree

var Conditions = [
	"is_idle",
	"is_walking"
]

func _ready():
	animation_tree.active = true

func set_condition(c):
	for i in Conditions:
		animation_tree["parameters/conditions/" + i] = i == c

func _process(_delta):
	var condition = "is_walking" if player.is_walking else "is_idle"
	set_condition(condition)
