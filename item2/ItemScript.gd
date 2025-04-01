extends Control
class_name WorldItem

@export var item_data: ItemData  # Assign the resource in the editor

func _ready():
	if item_data:
		$TextureRect.texture = item_data.texture
		size = Vector2(item_data.width * 32, item_data.height * 32)  # Adjust for grid
