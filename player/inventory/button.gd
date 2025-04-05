extends Control  # Or Button if you prefer

var current_item: ItemData  # Store the item currently in this slot (if any)
@export var DEFAULT_ITEM: ItemData

var dragging = false
var dragged_item = null
var dragged_texture = null
var dragged_slot_index = -1
signal slot_clicked(slot)


func _ready():
	current_item = DEFAULT_ITEM
	# Optionally, disable focus if you're using Control to avoid automatic visuals
	set_focus_mode(FOCUS_NONE)

# Detect drag event when clicking on the button/control

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		slot_clicked.emit(self)
		
