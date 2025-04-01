extends Area2D
class_name Item

@export var item_data: ItemData  # Holds size, texture, name
@export var pickup_range: float = 64.0  # How close player must be

func _ready():
	if item_data:
		$Sprite2D.texture = item_data.texture  # Assign item texture

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var player = get_tree().get_first_node_in_group("player")
		if player and is_player_near(player):
			if player.inventory.add_item(self):  # Add to inventory
				queue_free()  # Remove from world


func is_player_near(player) -> bool:
	return global_position.distance_to(player.global_position) <= pickup_range
