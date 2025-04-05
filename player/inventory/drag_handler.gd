extends Node

signal item_dropped(target_slot)

var dragging = false
var dragged_item = ItemData
var dragged_slot = null

@onready var dragged_icon = $DraggedIcon  # Reference to UI floating item

func _process(delta: float) -> void:
	pass

func start_dragging(item, slot_index):
	if dragging:
		return  # Prevent multiple drags

	dragging = true
	dragged_item = item
	dragged_slot = slot_index

	# Show floating icon
	#dragged_icon.texture = item[0].Texture
	#dragged_icon.visible = true

func update_drag_position():
	if dragging:
		var mouse_pos = get_viewport().get_mouse_position()  # Get global mouse position

		#dragged_icon.global_position = mouse_pos - Vector2(16, 16)  # Offset

func stop_dragging(slot_row,slot_col):
	if dragging:
		dragging = false
		#dragged_icon.visible = false
		item_dropped.emit(slot_row,slot_col, dragged_item)  # Notify inventory where the item was dropped
