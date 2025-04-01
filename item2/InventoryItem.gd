
extends Control
class_name InventoryItem

@export var item_data: ItemData  # Assign the same data as world item

func _ready():
	if item_data:
		$TextureRect.texture = item_data.texture  
		pass
