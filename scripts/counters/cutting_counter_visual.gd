extends CounterVisual

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func cut_performed():
	animation_player.stop()
	animation_player.play("cut")
