extends Control

@export var data: ItemData
@onready var icon = $TextureRect
@export var public_scale = 1

@export var slot_size := 32
var is_dragging := false
var drag_offset := Vector2.ZERO
const DRAG_THRESHOLD = 5.0
var press_position = Vector2()
func _ready(): 
	if data:
		icon.texture = data.icon
		scale = Vector2(data.height, data.width) * public_scale

#old
#func _gui_input(event): 
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#if event.pressed:
			#press_position = get_global_mouse_position()
		#else:
			#if is_dragging:
				#is_dragging = false
				#snap_to_grid()
	#elif event is InputEventMouseMotion and event.button_mask & MOUSE_BUTTON_MASK_LEFT:
		#if not is_dragging and press_position.distance_to(get_global_mouse_position()) > DRAG_THRESHOLD:
			#is_dragging = true
			##raise()
			
func _gui_input(event):
	var Inventory = get_parent().get_parent()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_dragging = true
			Inventory.begin_drag(self)  # only this item takes control
		else:
			if Inventory.dragging_item == self:
				is_dragging = false
				Inventory.end_drag()


func _process(delta):
	if is_dragging:
		global_position = get_global_mouse_position() - drag_offset
		#get_parent().get_parent().highlighting(self)
	#else: 
		#get_parent().get_parent().hide_drag_highlight()
		pass
		
#func snap_to_grid():    
	#var parent = get_parent().get_parent()
	#if parent.has_method("get_grid_origin") and parent.has_method("_slot_size") and parent.has_method("get_slot_spacing"):
		#var grid_origin = parent.get_grid_origin()
		#var spacing = parent.get_slot_spacing()
		#var slot_size = parent.slot_size
		#var cell_size = Vector2(slot_size, slot_size) + spacing
		#
		#var local_pos = global_position - grid_origin
		#var grid_x = int(local_pos.x / cell_size.x)
		#var grid_y = int(local_pos.y / cell_size.y)
		#var snapped_pos = grid_origin + Vector2(grid_x, grid_y) * cell_size
#
		#global_position = snapped_pos
		#print("item:",position)
	#else: 
		#print("ItemScript: something went wrong")
