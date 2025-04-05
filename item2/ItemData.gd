extends Resource
class_name ItemData

@export var name: String = "Unnamed Item"
@export var width: int = 1   # Grid width (e.g., 2 for a sword)
@export var height: int = 1  # Grid height (e.g., 3 for a large axe)
@export var grid_position: Vector2i
@export var texture: Texture2D
