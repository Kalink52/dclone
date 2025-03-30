extends Node2D

var teleport_range = 500  # Max range for teleportation

func _ready():
	# Example of binding teleportation to a key press (e.g., T)
	
	await get_tree().create_timer(0.3).timeout  # Effect lasts 0.3s
	queue_free()  # Destroy after playing effect
	Input.is_action_just_pressed("teleport") and teleport_to_mouse()

func teleport_to_mouse():
	var target_position = get_viewport().get_camera_2d().get_global_mouse_position()
	if target_position.distance_to(position) <= teleport_range:
		position = target_position
		
		# Optionally, play teleportation effect here
