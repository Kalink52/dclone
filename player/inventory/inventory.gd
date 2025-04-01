extends Control

@export var slot_scene: PackedScene  # Drag `Slot.tscn` here
@export var GRID_SIZE : int = 120  
@export var inventory_width : int = 20
@export var inventory_height : int = 6
var gold_amount: int = 0  # Store gold count

@onready var grid = $GridContainer
@onready var gold_label = $HBoxContainer/GoldAmount  # Adjust path if needed

var inventory_grid = []  # 2D array storing items
var slot_nodes = []  # Store UI slot nodes

func _ready():
	# Initialize a 10x4 grid (adjust size as needed)
	for x in range(inventory_width):
		inventory_grid.append([])
		for y in range(inventory_height):
			var slot = slot_scene.instantiate()
			grid.add_child(slot)
			inventory_grid[x].append(null)  # Empty slots
	for slot in grid.get_children():
		slot_nodes.append(slot)  # Store each slot
	update_gold_display()  # Ensure Gold shows at start

func add_gold(amount: int):
	gold_amount += amount
	update_gold_display()

func update_gold_display():
	gold_label.text = str(gold_amount)
	
func open_inventory():
	$InventoryUI.show()  # Makes it visible

func close_inventory():
	$InventoryUI.hide()  # Hides it

func add_item(item_data: ItemData) -> bool:
	var item_width = item_data.width
	var item_height = item_data.height

	# Iterate through the inventory grid to find an empty spot for the item
	for x in range(inventory_width):  # Loop through the grid width
		for y in range(inventory_height):  # Loop through the grid height
			# Check if the item fits in this spot without overlapping
			if can_place_item(x, y, item_width, item_height):
				# Place the item at the found position
				place_item_at(x, y, item_data)
				update_inventory_ui()
				return true

	# If no space is available
	return false

# Function to check if the item can be placed in the grid at the given position
func can_place_item(start_x: int, start_y: int, item_width: int, item_height: int) -> bool:
	for x in range(start_x, start_x + item_width):
		for y in range(start_y, start_y + item_height):
			if x >= inventory_width or y >= inventory_height or inventory_grid[x][y] != null:
				return false  # The slot is occupied or out of bounds
	return true

# Function to place the item at the specified grid location
func place_item_at(start_x: int, start_y: int, item_data: ItemData):
	for x in range(start_x, start_x + item_data.width):
		for y in range(start_y, start_y + item_data.height):
			inventory_grid[x][y] = item_data  # Mark the grid slot as occupied

func update_inventory_ui():
	var grid_width = inventory_grid[0].size()  # Assuming grid is rectangular
	var grid_height = inventory_grid.size()
	
	for y in range(grid_height):
		for x in range(grid_width):
			var slot_index = y * grid_width + x  # Convert 2D to 1D index
			var slot = slot_nodes[slot_index]  # Get the Control node
			
			# Get the TextureRect child inside the slot
			var texture_rect = slot.get_node("Texture")

			if inventory_grid[y][x] != null:
				texture_rect.texture = inventory_grid[y][x].texture  # Set the item's texture
				pass
			else:
				texture_rect.texture = null  # Clear the slot if empty
				pass
