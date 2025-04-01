extends Node
class_name InputHandler

# Signal to notify when the target position is updated
signal target_position_updated(target_position)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var target_pos = get_viewport().get_camera_2d().get_global_mouse_position()
		emit_signal("target_position_updated", target_pos)
	
	if event.is_action_pressed("toggle_inventory"):
		var inventory_UI = get_node("../InventoryUI")
		inventory_UI.visible = !inventory_UI.visible  # Toggle visibility
