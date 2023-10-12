extends CounterVisual

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	super()
	(counter as CuttingCounter).cut_performed.connect(func():
		animation_player.stop()
		animation_player.play("cut")
	)
