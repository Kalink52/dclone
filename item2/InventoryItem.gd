
extends Control
class_name InventoryItem

@export var item_data: ItemData  # Assign the same data as world item
var original_position: Vector2
var is_dragging = false
@onready var grid = get_parent()  # Assuming it's a child of GridContainer

func _ready():
	if item_data:
		$TextureRect.texture = item_data.texture  
		pass

# When the player starts dragging
func _gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			original_position = position  # Remember original position
			is_dragging = true
			grab_focus()  # Allow the item to follow mouse

		if event.released:
			if is_dragging:
				is_dragging = false
				var target_slot = get_target_slot()
				if target_slot:
					move_to_new_slot(target_slot)
				else:
					reset_position()

# Update item position to follow mouse while dragging
func _process(delta):
	if is_dragging:
		position = get_global_mouse_position() - size / 2  # Center the item at mouse position

# Get the grid position the item is dropped on
func get_target_slot() -> Vector2:
	var mouse_pos = get_global_mouse_position()
	var grid_pos = grid.to_local(mouse_pos)
	var slot_x = int(grid_pos.x / 10)
	var slot_y = int(grid_pos.y / 6)
	
	# Ensure it's within bounds
	if slot_x >= 0 and slot_y >= 0 and slot_x < 10 and slot_y < 4:
		return Vector2(slot_x, slot_y)
	
	return Vector2(-1,-1)  # If no valid slot

# Move the item to the new slot
func move_to_new_slot(new_slot: Vector2):
	var inventory = get_parent().get_parent()  # Assuming parent of grid is the main inventory
	if inventory.add_item(item_data, new_slot):
		queue_free()  # Item is now moved, free the old UI element

# Reset item to its original position if dropped outside
func reset_position():
	position = original_position
