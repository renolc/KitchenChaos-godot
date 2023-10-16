extends Control

@export var recipe_panel_scene: PackedScene

@onready var recipe_list: VBoxContainer = $WaitingRecipesList

func new_order_added(recipe: RecipeResource):
	var recipe_panel: RecipePanel = recipe_panel_scene.instantiate()
	recipe_panel.recipe = recipe
	recipe_list.add_child(recipe_panel)

func order_delivered(recipe: RecipeResource):
	for i in recipe_list.get_children():
		if i.recipe == recipe:
			recipe_list.remove_child(i)
			i.queue_free()
			break
