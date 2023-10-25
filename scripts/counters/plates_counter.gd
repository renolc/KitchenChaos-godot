extends BaseCounter

@export var plate_scene: PackedScene

@onready var plate_timer: Timer = $SpawnTimer

signal plate_spawned
signal plate_removed

const MAX_PLATES = 4

var plate_count := 0

func _ready():
	GameManager.Instance.state_changed.connect(func(state: GameManager.State):
		if state == GameManager.State.Playing:
			spawn_plate()
			plate_timer.start()
	)

func interact():
	if plate_count > 0 && !Player.Instance.ko:
		plate_count -= 1
		var plate := plate_scene.instantiate() as KitchenObject
		if plate.try_set_holder(Player.Instance):
			plate_removed.emit()

func spawn_plate():
	if plate_count == MAX_PLATES: return

	plate_count += 1
	plate_spawned.emit()
