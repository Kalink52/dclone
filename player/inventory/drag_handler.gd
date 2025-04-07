extends Node

@onready var drag_highlight = $DragHighlight
@export var slot_size := 32
@onready var inventory = get_parent()

func update_drag_highlight(grid_pos: Vector2i, item_size: Vector2i):
	var spacing = inventory.get_slot_spacing()
	var cell_size = Vector2(slot_size, slot_size) + spacing
	var top_left = inventory.get_grid_origin() + Vector2(grid_pos) * cell_size

	drag_highlight.global_position = top_left
	drag_highlight.size = cell_size * Vector2(item_size)
	drag_highlight.visible = true
