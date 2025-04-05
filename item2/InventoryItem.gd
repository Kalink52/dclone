
extends Control
class_name InventoryItem

@export var item_data: ItemData  # Assign the same data as world item
@onready var grid = get_parent()  # Assuming it's a child of GridContainer


func _ready():
	if item_data:
		$TextureRect.texture = item_data.texture  
		pass

# When the player starts dragging
