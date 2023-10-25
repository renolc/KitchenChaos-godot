extends WorldCanvas

@export_category("success")
@export var success_color := Color("529937")
@export var success_text = "DELIVERY SUCCESS"
@export var success_icon: Texture

@export_category("failure")
@export var failure_color := Color("ab1919")
@export var failure_text = "DELIVERY FAILED"
@export var failure_icon: Texture

@onready var bg: ColorRect = $SubViewport/Outline/BG
@onready var label: Label = $SubViewport/Outline/BG/Label
@onready var icon: TextureRect = $SubViewport/Outline/BG/Icon
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	super()
	DeliveryManager.Instance.delivery_success.connect(func(success):
		if success:
			bg.color = success_color
			label.text = success_text
			icon.texture = success_icon
			pop()
		else:
			bg.color = failure_color
			label.text = failure_text
			icon.texture = failure_icon
			pop()
	)

func pop():
	show()
	animation_player.play("pop")
	await animation_player.animation_finished
	hide()
