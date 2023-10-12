extends CounterVisual

@onready var on_visual: MeshInstance3D = $StoveCounter_Visual/StoveCounter_Visual2/StoveOnVisual

func progress_update(v: float):
	on_visual.visible = v > 0 && v < 1
