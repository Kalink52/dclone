extends Control

@export var slot_scene: PackedScene  # Drag `Slot.tscn` here
@export var GRID_SIZE : int = 40  
var gold_amount: int = 0  # Store gold count

@onready var grid = $GridContainer
@onready var gold_label = $HBoxContainer/GoldAmount  # Adjust path if needed

var inventory_grid = []  # 2D array storing items

func _ready():
	# Initialize a 10x4 grid (adjust size as needed)
	for x in range(10):
		inventory_grid.append([])
		for y in range(4):
			var slot = slot_scene.instantiate()
			grid.add_child(slot)
			inventory_grid[x].append(null)  # Empty slots
			
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

func add_item(item: Item) -> bool:
	var item_width = item.item_data.width
	var item_height = item.item_data.height

	# Find a free slot that fits the item
	for x in range(len(inventory_grid) - item_width + 1):
		for y in range(len(inventory_grid[0]) - item_height + 1):
			if can_fit_item(x, y, item_width, item_height):
				place_item(x, y, item)
				return true
	return false  # No space available

func can_fit_item(x: int, y: int, width: int, height: int) -> bool:
	# Ensure the item fits within the inventory grid
	for i in range(width):
		for j in range(height):
			if inventory_grid[x + i][y + j] != null:
				return false  # Slot occupied
	return true

func place_item(x: int, y: int, item: Item):
	# Mark inventory slots as occupied
	for i in range(item.item_data.width):
		for j in range(item.item_data.height):
			inventory_grid[x + i][y + j] = item

	# Create the inventory UI item
	var inventory_item = preload("res://item2/InventoryItem.tscn").instantiate()
	inventory_item.item_data = item.item_data  # Assign item data
	inventory_item.position = Vector2(x * GRID_SIZE, y * GRID_SIZE)
	grid.add_child(inventory_item)  # Add to inventory UI grid

	# Remove the world item
	item.queue_free()
