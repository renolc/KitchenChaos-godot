extends CounterVisual

@onready var door := $"ContainerCounter_Visual/ContainerCounter_Visual2/Single door"
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	super()
	(counter as ContainerCounter).player_grabbed_object.connect(play_open_anim)

func play_open_anim():
	animation_player.play("open")
