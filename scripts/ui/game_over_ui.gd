extends Control

@onready var delivered_count: Label = $RecipiesDeliveredValueLabel

func state_changed(state: GameManager.State):
	if state == GameManager.State.GameOver:
		delivered_count.text = str(DeliveryManager.Instance.orders_delivered)
		show()
