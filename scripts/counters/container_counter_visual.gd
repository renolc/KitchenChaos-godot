@tool
extends CounterVisual

@onready var door := $"ContainerCounter_Visual/ContainerCounter_Visual2/Single door"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite3D = $"ContainerCounter_Visual/ContainerCounter_Visual2/Single door/ObjectSprite/Sprite3D"

func _ready() -> void:
	if !Engine.is_editor_hint(): super()

	var parent := counter as ContainerCounter
	if !parent: return

	if !Engine.is_editor_hint():
		parent.player_grabbed_object.connect(play_open_anim)

	set_sprite(parent.scene)

func set_sprite(scene: PackedScene):
	if !scene:
		sprite.texture = null
		return

	var tmp := scene.instantiate() as KitchenObject
	sprite.texture = tmp.sprite
	tmp.queue_free()

func play_open_anim():
	animation_player.play("open")
