extends Control

@export var columns := 12
@export var rows := 6
@export var slot_size := 32
@onready var drag_highlight = $DragHighlight
@onready var slotimgscale := 1
@onready var grid = $GridContainer
@onready var items_layer = $ItemsLayer
@onready var slotScene = preload("res://player/inventory/slotpanel.tscn")
var ItemScene = preload("res://item2/Item.tscn")
var SwordData = preload("res://item2/testitems/sword.tres")
var ShieldData = preload("res://item2/testitems/shield.tres")

func _ready():
	setup_grid()
	populate_slots()
	
	spawn_item(SwordData, Vector2i(0, 0))
	#spawn_item(ShieldData, Vector2i(4, 0))
	#spawn_item(SwordData, Vector2i(11, 0))
	



func setup_grid():
	grid.columns = columns
	grid.name = "Grid"
	grid.size_flags_horizontal = SIZE_EXPAND_FILL
	grid.size_flags_vertical = SIZE_EXPAND_FILL
	add_child(grid)

func populate_slots():
	for y in range(rows):
		for x in range(columns):
			var slot = slotScene.instantiate()
			slot.custom_minimum_size = Vector2(slot_size, slot_size)
			slot.add_theme_stylebox_override("panel", get_default_slot_style())
			grid.add_child(slot)

func get_default_slot_style() -> StyleBoxFlat:
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.1, 0.1, 0.1, 0.8)
	style.set_border_width_all(1)
	style.border_color = Color(0.5, 0.5, 0.5)
	return style

func spawn_item(data: ItemData, grid_position: Vector2i):
	var item = ItemScene.instantiate()
	item.data = data
	item.position = grid_to_position(grid_position)
	print("inventory:",item.position)
	item.public_scale = slotimgscale
	items_layer.add_child(item)
	
func grid_to_position(grid_pos: Vector2i) -> Vector2:
	var spacing = get_slot_spacing()
	return Vector2(grid_pos.x, grid_pos.y) * slot_size + Vector2(grid_pos.x * spacing[0], grid_pos.y * spacing[1] )

func get_grid_origin() -> Vector2:
	return grid.get_global_rect().position

func _slot_size() -> int:
	return slot_size
	
func get_slot_spacing() -> Vector2:
	var hsep := 0
	var vsep := 0
	if grid.has_theme_constant("h_separation"):
		hsep = grid.get_theme_constant("h_separation")
	if grid.has_theme_constant("v_separation"):
		vsep = grid.get_theme_constant("v_separation")
	return Vector2(hsep, vsep)

func get_cell_position(grid_x: int, grid_y: int) -> Vector2:
	var spacing = get_slot_spacing()
	var cell_size = Vector2(slot_size, slot_size) + spacing
	return get_grid_origin() + Vector2(grid_x, grid_y) * cell_size

func highlighting(item: ItemData):
	#if dragging_item:
	var mouse_pos = get_viewport().get_mouse_position()
	var local = mouse_pos - get_grid_origin()
	var spacing = get_slot_spacing()
	var cell_size = Vector2(slot_size, slot_size) + spacing
	var grid_x = int(local.x / cell_size.x)
	var grid_y = int(local.y / cell_size.y)
	update_drag_highlight(Vector2i(grid_x, grid_y), Vector2i(item.height, item.width))

	
func update_drag_highlight(grid_pos: Vector2i, item_size: Vector2i):
	var spacing = get_slot_spacing()
	var cell_size = Vector2(slot_size, slot_size) + spacing
	var top_left = get_grid_origin() + Vector2(grid_pos) * cell_size

	drag_highlight.global_position = top_left
	drag_highlight.size = cell_size * Vector2(item_size)
	drag_highlight.visible = true

func hide_drag_highlight():
	
	drag_highlight.visible = false
