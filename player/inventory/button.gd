extends Control  # Or Button if you prefer

var current_item: ItemData  # Store the item currently in this slot (if any)
@export var DEFAULT_ITEM: ItemData
var is_dragging = false

func _ready():
	current_item = DEFAULT_ITEM
	# Optionally, disable focus if you're using Control to avoid automatic visuals
	set_focus_mode(FOCUS_NONE)

# Detect drag event when clicking on the button/control
func _gui_input(event):
	#print("enable input")
	if current_item != null:
		print(current_item)
	pass
	#if event is InputEventMouseButton:
		#if event.pressed:
			## Check if the mouse is inside the bounds of the control
			#var mouse_pos = get_local_mouse_position()
			#if mouse_pos.x >= 0 and mouse_pos.y >= 0 and mouse_pos.x <= size.x and mouse_pos.y <= size.y:
				#get_parent().is_dragging = true  # Indicate that something is being dragged
				#get_parent().dragged_item = current_item  # Pass the dragged item
		#elif event.released and get_parent().is_dragging:
			## Check if the mouse is still inside the bounds on release
			#var mouse_pos = get_local_mouse_position()
			#if mouse_pos.x >= 0 and mouse_pos.y >= 0 and mouse_pos.x <= size.x and mouse_pos.y <= size.y:
				#get_parent().add_item(get_parent().dragged_item, position)
			#get_parent().is_dragging = false  # Reset dragging status
			#current_item = get_parent().dragged_item  # Update slot item
