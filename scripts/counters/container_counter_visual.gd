extends CounterVisual

@onready var door := $"ContainerCounter_Visual/ContainerCounter_Visual2/Single door"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite3D = $"ContainerCounter_Visual/ContainerCounter_Visual2/Single door/ObjectSprite/Sprite3D"

func _ready() -> void:
	super()
	var parent := counter as ContainerCounter
	parent.player_grabbed_object.connect(play_open_anim)

	var tmp := parent.scene.instantiate() as KitchenObject
	sprite.texture = tmp.sprite
	tmp.queue_free()

func play_open_anim():
	animation_player.play("open")
